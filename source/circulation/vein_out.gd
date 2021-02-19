class_name VeinOut extends Sprite


func _init() -> void:
	self.material = self.material.duplicate()
	self.material.set_shader_param("y_start", 0.0)
	self.material.set_shader_param("y_end", 1.0)
