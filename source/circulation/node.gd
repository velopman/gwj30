class_name CirculationNode extends Node


var _next_node: CirculationNode
var _previous_node: CirculationNode


func flow(from_node: CirculationNode) -> void:
	if self._next_node:
		self._next_node.flow(self)


func set_next_node(node: CirculationNode) -> void:
	self._next_node = node
	node._set_previous_node(self)


func _set_previous_node(node: CirculationNode) -> void:
	self._previous_node = node
