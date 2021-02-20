extends TextureButton

var __over: bool = false
var __elapsed_time: float = 0.0
onready var __base_scale: float = self.rect_scale.x

func _ready() -> void:
	self.connect("mouse_entered", self, "set", ["__over", true])
	self.connect("mouse_exited", self, "set", ["__over", false])
	self.rect_pivot_offset = self.rect_size * 0.5


func _process(delta: float) -> void:
	self.__elapsed_time += delta * 5.0
	if self.__over:
		var scale = clamp(0.2 + sin(self.__elapsed_time), 1.0, 1.2)
		self.rect_scale = Vector2.ONE * scale * self.__base_scale
	else:
		self.rect_scale = Vector2.ONE * self.__base_scale
