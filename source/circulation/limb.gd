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


		if !node is CirculationNode:
			continue

		node.set_limb(self)

		if previous_node:
			previous_node.set_next_node(node)
			self.__nodes.append(node)
		previous_node = node

	previous_node.set_next_node(self)


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


func flow(from_node: CirculationNode) -> void:
	if from_node == null:
		.flow(from_node)
		self.__handle_visual_flow()
	else:
		self._update_health(self.HEALTH_REGEN)


func kill() -> void:
	.kill()

	for node in self.__nodes:
		self.__timer.start(0.1)
		yield(self.__timer, "timeout")
		node.kill()


# Protected methods
func _update_health(amount: float) -> void:
	if self._dead:
		return

	self.__health += amount
	self.__health = clamp(self.__health, self.HEALTH_MIN, self.HEALTH_MAX)

	if self.__health == self.HEALTH_MIN:
		self.kill()


# Private methods
func __handle_visual_flow() -> void:
	var blocked_index: int = -1

	for index in self.__nodes.size():
		if self.__nodes[index].is_blocked():
			blocked_index = index
			break

	var start_time = OS.get_ticks_msec() / 1000.0
	self.__vein_out.material.set_shader_param("start_time", start_time)

	if self.is_blocked() && blocked_index < self.__nodes.size() / 2:
		var blocked_y: float = self.__nodes[blocked_index].position.y
		self.__vein_out.material.set_shader_param("blocked_y", blocked_y)
		return

	self.__timer.start(0.3)
	yield(self.__timer, "timeout")

	start_time = OS.get_ticks_msec() / 1000.0
	self.__vein_in.material.set_shader_param("start_time", start_time)


	if self.is_blocked() && blocked_index >= self.__nodes.size() / 2:
		var blocked_y: float = self.__nodes[blocked_index].position.y
		self.__vein_out.material.set_shader_param("blocked_y", blocked_y)
