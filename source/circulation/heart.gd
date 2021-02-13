extends Button


onready var __limbs = self.get_children()

var __limb_nodes = []


func _ready() -> void:
	for limb in self.__limbs:
		var previous_node = null
		var blockages = []
		for node in limb.get_children():
			if node is Blockage:
				blockages.append(node)
			elif node is BlockageEnd:
				node = blockages.pop_back()

			if previous_node:
				previous_node.set_next_node(node)
			else:
				self.__limb_nodes.append(node)
			previous_node = node
	self.connect("pressed", self, "__pressed")


func __pressed():
	for limb_node in self.__limb_nodes:
		limb_node.flow()
