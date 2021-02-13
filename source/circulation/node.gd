class_name CirculationNode extends Node


var next_node: CirculationNode


func flow() -> void:
	if self.next_node:
		self.next_node.flow()


func set_next_node(node: CirculationNode) -> void:
	self.next_node = node
