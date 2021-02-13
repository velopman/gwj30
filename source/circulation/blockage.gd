class_name Blockage extends CirculationNode


var _outgoing_node = null
var _incoming_node = null

var __blocked = false


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		self.__blocked = !self.__blocked


func flow(from_node: CirculationNode) -> void:
	if self.__blocked || from_node != self._previous_node:
		self._incoming_node.flow(self)
	else:
		self._outgoing_node.flow(self)


func set_next_node(node: CirculationNode) -> void:
	if self._outgoing_node == null:
		.set_next_node(node)
		self._outgoing_node = node
	else:
		self._incoming_node = node


func _set_previous_node(node: CirculationNode) -> void:
	if self._previous_node == null:
		._set_previous_node(node)
