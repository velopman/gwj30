class_name Limb extends CirculationNode


const HEALTH_MIN: float = 0.0
const HEALTH_MAX: float = 100.0

var _health: float = HEALTH_MAX


func _process(delta: float) -> void:
	self._update_health(-delta)


func flow(from_node: CirculationNode) -> void:
	.flow(from_node)

	self._update_health(5.0)


func _update_health(amount: float) -> void:
	self._health += amount
	self._health = clamp(self._health, self.HEALTH_MIN, self.HEALTH_MAX)
	self.value = self._health
