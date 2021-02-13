class_name Blockage extends CirculationNode


var outgoing_node = null
var incoming_node = null

var __blocked = false


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		self.__blocked = !self.__blocked
		self.next_node = self.incoming_node if self.__blocked else self.outgoing_node


func set_next_node(node: CirculationNode) -> void:
	if self.outgoing_node == null:
		.set_next_node(node)
		self.outgoing_node = node
	else:
		self.incoming_node = node
