class_name Vein extends CirculationNode

onready var flow_timer = $flow_timer

func _ready() -> void:
	self.modulate = Color.gray


func flow() -> void:
	self.modulate = Color.white

	self.flow_timer.start(0.1)
	yield(flow_timer, "timeout")

	.flow()

	self.flow_timer.start(0.1)
	yield(flow_timer, "timeout")

	self.modulate = Color.gray
