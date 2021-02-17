extends Node2D

onready var __button = $button

var __limb_nodes = []


func _ready() -> void:
	for limb in self.get_children():
		if limb is Limb:
			self.__limb_nodes.append(limb)

	self.__button.connect("pressed", self, "__pressed")


func __pressed():
	for limb_node in self.__limb_nodes:
		limb_node.flow(null)
