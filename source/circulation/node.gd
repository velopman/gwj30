class_name CirculationNode extends Node


var _blocked: bool = false
var _dead: bool = false
var _limb: CirculationNode = null
var _next_node: CirculationNode = null
var _previous_node: CirculationNode = null


# Public methods
func block() -> void:
	self._blocked = true


func flow(from_node: CirculationNode) -> void:
	if self._next_node:
		self._next_node.flow(self)


func is_blocked() -> bool:
	return self._blocked


func is_dead() -> bool:
	return self._dead


func kill() -> void:
	self._dead = true


func set_limb(node: CirculationNode) -> void:
	self._limb = node


func set_next_node(node: CirculationNode) -> void:
	self._next_node = node
	node._set_previous_node(self)


func unblock() -> void:
	self._blocked = false

	if self._limb:
		self._limb.unblock()


# Protected methods
func _set_previous_node(node: CirculationNode) -> void:
	self._previous_node = node
