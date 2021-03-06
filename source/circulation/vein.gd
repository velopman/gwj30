class_name Vein extends CirculationNode

signal hide_fix()


onready var __hazard: TextureButton = $hazard_container/hazard
onready var __hazard_container: Node2D = $hazard_container
onready var __sprite: Sprite = $sprite
onready var __timer: Timer = $timer
onready var __tutorial: Sprite = $hazard_container/tutorial_fix

var out: bool = false

var __disabled: bool = false
var __over: bool = false
var __show_tutorial: bool = true


# Lifecycle methods
func _ready() -> void:
	self.__hazard_container.rotation = -self.global_rotation
	self.__hazard_container.global_scale = Vector2.ONE

	Event.connect("unblock_started", self, "__disable", [true])
	Event.connect("unblock_finished", self, "__disable", [false])
	Event.connect("hide_fix", self, "set", ["__show_tutorial", false])


# Public Methods
func block() -> void:
	.block()

	self.__hazard.visible = true
	self.__tutorial.visible = self.__show_tutorial
	if self.__show_tutorial:
		Event.emit_signal("hide_fix")
	self.__hazard.disabled = false || self.__disabled
	if !self.__disabled:
		self.__hazard.mouse_filter = self.__hazard.MOUSE_FILTER_STOP


func flow(from_node: CirculationNode) -> void:
	if self._blocked || self._dead:
		return

	self.__timer.start(0.1)
	yield(self.__timer, "timeout")

	if !self._blocked:
		.flow(from_node)

	self.__timer.start(0.1)
	yield(self.__timer, "timeout")


func kill() -> void:
	.kill()

	self.unblock()


func unblock() -> void:
	.unblock()

	self.__hazard.visible = false
	self.__hazard.mouse_filter = self.__hazard.MOUSE_FILTER_IGNORE


# Private methods
func __disable(value: bool) -> void:
	if value:
		self.__hazard.mouse_filter = self.__hazard.MOUSE_FILTER_IGNORE
	else:
		self.__hazard.mouse_filter = self.__hazard.MOUSE_FILTER_STOP

	self.__disabled = value
	self.__hazard.disabled = value


func _on_hazard_pressed():
	self.__tutorial.visible = false

	Event.emit_signal("unblock_config", self.global_position, self.out)
	Event.emit_signal("unblock_started")

	self.__hazard.mouse_filter = self.__hazard.MOUSE_FILTER_IGNORE
	self.__hazard.disabled = true

	yield(Event, "unblock_finished")
	self.unblock()
