class_name Limb extends CirculationNode


const HEALTH_MIN: float = 0.0
const HEALTH_MAX: float = 25.0
const HEALTH_REGEN: float = 2.5

onready var __timer: Timer  = $timer

var __nodes: Array = []
var __health: float = HEALTH_MAX


# Lifecycle methods
func _ready() -> void:
	self.add_to_group("blockable")

	var previous_node = self

	for node in self.get_children():
		if !node is CirculationNode:
			continue

		node.set_limb(self)

		if previous_node:
			previous_node.set_next_node(node)
			self.__nodes.append(node)
		previous_node = node

	previous_node.set_next_node(self)


func _process(delta: float) -> void:
	self._update_health(-delta)


# Public methods
func block() -> void:
	if self._blocked || self._dead:
		return

	.block()

	var index: int = randi() % self.__nodes.size()
	self.__nodes[index].block()


func flow(from_node: CirculationNode) -> void:
	if from_node == null:
		.flow(from_node)
	else:
		self._update_health(self.HEALTH_REGEN)


func kill() -> void:
	.kill()

	for node in self.__nodes:
		self.__timer.start(0.1)
		yield(self.__timer, "timeout")
		node.kill()


# Protected methods
func _update_health(amount: float) -> void:
	if self._dead:
		return

	self.__health += amount
	self.__health = clamp(self.__health, self.HEALTH_MIN, self.HEALTH_MAX)

	if self.__health == self.HEALTH_MIN:
		self.kill()
