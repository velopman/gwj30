extends Node2D

onready var __button: TextureButton = $button
onready var __heartbeat: AudioStreamPlayer = $heartbeat

var __limb_nodes = []
var __pumping = false


# Lifecycle methods
func _ready() -> void:
	for limb in self.get_children():
		if limb is Limb:
			self.__limb_nodes.append(limb)

	self.__button.connect("pressed", self, "__pressed")
	Event.connect("unblock_started", self, "__disable", [true])
	Event.connect("unblock_finished", self, "__disable", [false])


# Public methods
func limb_count() -> int:
	var count: int = 0

	for limb in self.__limb_nodes:
		if !limb.is_dead():
			count += 1

	return count


# Private methods
func __disable(value: bool) -> void:
	if value:
		self.__button.mouse_filter = self.__button.MOUSE_FILTER_IGNORE
	else:
		self.__button.mouse_filter = self.__button.MOUSE_FILTER_STOP

	self.__button.disabled = value


func __pressed():
	if self.__pumping:
		return

	self.__heartbeat.play()
	for limb_node in self.__limb_nodes:
		limb_node.flow(null)

	self.__button.disabled = true
	self.__pumping = true

	yield(self.__heartbeat, "finished")

	self.__button.disabled = false
	self.__pumping = false
