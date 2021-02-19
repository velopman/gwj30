class_name VeinIn extends Sprite


func _init() -> void:
	self.material = self.material.duplicate()
	self.material.set_shader_param("y_start", 1.0)
	self.material.set_shader_param("y_end", 0.0)
