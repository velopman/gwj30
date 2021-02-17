class_name Limb extends CirculationNode


const HEALTH_MIN: float = 0.0
const HEALTH_MAX: float = 100.0

onready var __nodes: Array = self.get_children()

var _health: float = HEALTH_MAX


# Lifecycle methods
func _ready() -> void:
	self.add_to_group("blockable")

	var previous_node = self

	for node in self.__nodes:
		node.set_limb(self)

		if previous_node:
			previous_node.set_next_node(node)
		previous_node = node

	previous_node.set_next_node(self)


func _process(delta: float) -> void:
	self._update_health(-delta)


# Public methods
func block() -> void:
	if self._blocked:
		return

	.block()

	var index: int = randi() % self.__nodes.size()
	self.__nodes[index].block()


func flow(from_node: CirculationNode) -> void:
	if from_node == null:
		.flow(from_node)
	else:
		self._update_health(5.0)


# Protected methods
func _update_health(amount: float) -> void:
	self._health += amount
	self._health = clamp(self._health, self.HEALTH_MIN, self.HEALTH_MAX)
