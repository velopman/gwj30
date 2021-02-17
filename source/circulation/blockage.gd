class_name Blockage extends CirculationNode


var _outgoing_node = null
var _incoming_node = null

var __blocked = false


func _ready():
	self.add_to_group("blockage")


func block() -> void:
	self.__blocked = true
	self.modulate = Color.red


func flow(from_node: CirculationNode) -> void:
	if self.__blocked || from_node != self._previous_node:
		self._incoming_node.flow(self)
	else:
		self._outgoing_node.flow(self)


func is_blocked() -> bool:
	return self.__blocked


func set_next_node(node: CirculationNode) -> void:
	if self._outgoing_node == null:
		.set_next_node(node)
		self._outgoing_node = node
	else:
		self._incoming_node = node


func _set_previous_node(node: CirculationNode) -> void:
	if self._previous_node == null:
		._set_previous_node(node)


func _on_area_input_event(viewport, event, shape_idx):
	if !self.__blocked:
		return

	if event is InputEventMouseButton && event.button_index == BUTTON_LEFT && event.is_pressed():
		Event.emit_signal("unblock_started")
		yield(Event, "unblock_finished")

		self.__blocked = false
		self.modulate = Color.white
