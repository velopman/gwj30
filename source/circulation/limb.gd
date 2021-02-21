class_name Limb extends CirculationNode


const HEALTH_MIN: float = 0.0
const HEALTH_MAX: float = 25.0
const HEALTH_REGEN: float = 2.5

onready var __timer: Timer  = $timer
onready var __blocked_audio: AudioStreamPlayer2D = $blocked

var __nodes: Array = []
var __health: float = HEALTH_MAX
var __vein_in: VeinIn = null
var __vein_out: VeinOut = null
var __limb_health: LimbHealth = null


# Lifecycle methods
func _ready() -> void:
	self.add_to_group("blockable")

	var previous_node = self

	for node in self.get_children():
		if node is VeinIn:
			self.__vein_in = node
			continue

		if node is VeinOut:
			self.__vein_out = node
			continue

		if node is LimbHealth:
			self.__limb_health = node
			continue


		if !node is CirculationNode:
			continue

		node.set_limb(self)

		if previous_node:
			previous_node.set_next_node(node)
			self.__nodes.append(node)
		previous_node = node

	previous_node.set_next_node(self)

	var size = self.__nodes.size()
	for index in self.__nodes.size():
		self.__nodes[index].out = index < size / 2


func _process(delta: float) -> void:
	self._update_health(-delta)


# Public methods
func block() -> void:
	if self._blocked || self._dead:
		return

	.block()

	var index: int = randi() % self.__nodes.size()
	self.__nodes[index].block()
	self.__blocked_audio.play()
	self.z_index = -1


func flow(from_node: CirculationNode) -> void:
	if self._dead:
		return

	if from_node == null:
		.flow(from_node)
		self.__handle_flow()
	else:
		self._update_health(self.HEALTH_REGEN)


func kill() -> void:
	.kill()

	for node in self.__nodes:
		node.kill()

	self.__vein_out.material.set_shader_param("is_dead", true)

	var start_time = OS.get_ticks_msec() / 1000.0 + 10.0
	self.__vein_in.material.set_shader_param("start_time", start_time)
	self.__vein_in.material.set_shader_param("is_dead", true)

	yield(self.__handle_flow(0.5), "completed")
	self.z_index = -2

	Event.emit_signal("limb_died")


func unblock() -> void:
	.unblock()

	self.z_index = 0


# Protected methods
func _update_health(amount: float) -> void:
	if self._dead:
		return

	self.__health += amount
	self.__health = clamp(self.__health, self.HEALTH_MIN, self.HEALTH_MAX)
	self.__limb_health.set_health(self.__health / self.HEALTH_MAX + self.HEALTH_MIN)

	if self.__health == self.HEALTH_MIN:
		self.kill()


# Private methods
func __handle_flow(time_scale: float = 0.3) -> void:
	var blocked_index: int = -1

	for index in self.__nodes.size():
		if self.__nodes[index].is_blocked():
			blocked_index = index
			break

	var blocked_out = (
		!self._dead &&
		self._blocked &&
		blocked_index < self.__nodes.size() / 2
	)
	self.__handle_vein_flow(self.__vein_out, blocked_index, blocked_out, time_scale)

	if blocked_out:
		return

	self.__timer.start(time_scale)
	yield(self.__timer, "timeout")

	var blocked_in = (
		!self._dead &&
		self._blocked &&
		blocked_index >= self.__nodes.size() / 2
	)
	self.__handle_vein_flow(self.__vein_in, blocked_index, blocked_in, time_scale)


func __handle_vein_flow(vein, blocked_index: int, blocked: bool, time_scale: float) -> void:
	var start_time = OS.get_ticks_msec() / 1000.0
	vein.material.set_shader_param("start_time", start_time)
	vein.material.set_shader_param("time_scale", time_scale)

	var blocked_y: float = 0.0 if vein is VeinIn else 2.0
	if blocked:
		blocked_y = self.__nodes[blocked_index].position.y
		blocked_y = self.__to_texture_space(vein, blocked_y)
	vein.material.set_shader_param("blocked_y", blocked_y)


func __to_texture_space(sprite: Sprite, y_position: float) -> float:
	var texture: Texture = sprite.texture
	var image: Image = texture.get_data()
	var height: float = image.get_height()

	return (y_position - (sprite.position.y - height / 2.0)) / height
