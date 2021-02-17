class_name Vein extends CirculationNode


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
	self.__sprite.modulate = Color.gray


func _process(delta: float) -> void:
	self.__handle_block()



# Public Methods
func block() -> void:
	.block()
	self.__sprite.modulate = Color.red

	self.__hazard.visible = true
	self.__hazard.rotation = -self.global_rotation
	self.__hazard.global_position = self.global_position + Vector2(0.0, -16.0)

	for area in self.__areas:
		area.input_pickable = true


func flow(from_node: CirculationNode) -> void:
	if self._blocked:
		return

	self.__sprite.modulate = Color.white

	self.__timer.start(0.1)
	yield(self.__timer, "timeout")

	if !self._blocked:
		.flow(from_node)

	self.__timer.start(0.1)
	yield(self.__timer, "timeout")

	if !self._blocked:
		self.__sprite.modulate = Color.gray


func unblock() -> void:
	.unblock()

	self.__hazard.visible = false
	self.__sprite.modulate = Color.gray


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
