extends Node


# Time globals

# Current rate of time passing.
#	1.0 is default
#	< 1.0 is slowed down
#	> 1.0 is speed up
var time_modifier = 1.0


# Game constants
const COLOR_OUT: Color = Color("ac3232")
const COLOR_IN: Color = Color("5b6ee1")


# Game globals
var unblocking: bool = false
var unblock_out: bool = false
var unblock_position: Vector2 = Vector2(640.0, 360.0)


# Lifecycle methods
func _ready() -> void:
	Event.connect("unblock_started", self, "__set_unblocking", [true])
	Event.connect("unblock_finished", self, "__set_unblocking", [false])
	Event.connect("unblock_config", self, "__set_unblock_config")

# Public method
func get_unblocking_color() -> Color:
	if self.unblock_out:
		return self.COLOR_OUT
	return self.COLOR_IN


# Private methods
func __set_unblocking(value: bool) -> void:
	self.unblocking = value


func __set_unblock_config(position: Vector2, out: bool) -> void:
	self.unblock_position = position
	self.unblock_out = out
