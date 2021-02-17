extends Node2D

onready var __button = $button

var __limb_nodes = []


# Lifecycle methods
func _ready() -> void:
	for limb in self.get_children():
		if limb is Limb:
			self.__limb_nodes.append(limb)

	self.__button.connect("pressed", self, "__pressed")


# Public methods
func limb_count() -> int:
	var count: int = 0

	for limb in self.__limb_nodes:
		if !limb.is_dead():
			count += 1

	return count


# Private methods
func __pressed():
	for limb_node in self.__limb_nodes:
		limb_node.flow(null)
