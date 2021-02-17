extends Node


# Time globals

# Current rate of time passing.
#	1.0 is default
#	< 1.0 is slowed down
#	> 1.0 is speed up
var time_modifier = 1.0


# Game globals
var unblocking = false


# Lifecycle methods
func _ready() -> void:
	Event.connect("unblock_started", self, "__set_unblocking", [true])
	Event.connect("unblock_finished", self, "__set_unblocking", [false])


# Private methods
func __set_unblocking(value: bool) -> void:
	self.unblocking = value
