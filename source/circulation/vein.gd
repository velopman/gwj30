class_name Vein extends CirculationNode


export(Color) var color_normal = Color("5a9d2c")
export(Color) var color_flowing = Color("6abe30")
export(Color) var color_blocked = Color("8c2020")
export(Color) var color_dead = Color("3e3e3e")


onready var __areas: Array = [
	$hazard/area,
	$sprite/area
]
onready var __hazard: Sprite = $hazard
onready var __sprite: Sprite = $sprite
onready var __timer: Timer = $timer

var __over: bool = false


# Lifecycle methods
func _ready() -> void:
	self.__sprite.modulate = self.color_normal


func _process(delta: float) -> void:
	self.__handle_block()


# Public Methods
func block() -> void:
	.block()
	self.__sprite.modulate = self.color_blocked

	self.__hazard.visible = true
	self.__hazard.rotation = -self.global_rotation
	self.__hazard.global_position = self.global_position + Vector2(0.0, -16.0)

	for area in self.__areas:
		area.input_pickable = true


func flow(from_node: CirculationNode) -> void:
	if self._blocked || self._dead:
		return

	self.__sprite.modulate = self.color_flowing

	self.__timer.start(0.1)
	yield(self.__timer, "timeout")

	if !self._blocked:
		.flow(from_node)

	self.__timer.start(0.1)
	yield(self.__timer, "timeout")

	if !self._blocked && !self._dead:
		self.__sprite.modulate = self.color_normal


func kill() -> void:
	.kill()

	self.unblock()
	self.__sprite.modulate = self.color_dead



func unblock() -> void:
	.unblock()

	self.__hazard.visible = false

	if !self._blocked && !self._dead:
		self.__sprite.modulate = self.color_normal

	for area in self.__areas:
		area.input_pickable = false

# Private methods
func __handle_block() -> void:
	if !self._blocked || Globals.unblocking:
		return

	if self.__over && Input.is_action_just_released("pressed"):
		Event.emit_signal("unblock_started")

		yield(Event, "unblock_finished")
		self.unblock()


# Signals
func _on_mouse_entered():
	self.__over = true


func _on_mouse_exited():
	self.__over = false
