extends TextureButton


export (String) var scene_name

var __over: bool = false
var __elapsed_time: float = 0.0

func _ready() -> void:
	self.connect("button_up", self, "change_scene")
	self.connect("mouse_entered", self, "set", ["__over", true])
	self.connect("mouse_exited", self, "set", ["__over", false])
	self.rect_pivot_offset = self.rect_size * 0.5


func _process(delta: float) -> void:
	self.__elapsed_time += delta * 5.0
	if self.__over:
		var scale = clamp(0.2 + sin(self.__elapsed_time), 1.0, 1.2)
		self.rect_scale = Vector2.ONE * scale
	else:
		self.rect_scale = Vector2.ONE


func change_scene() -> void:
	MenuMusic.play_button_sound()
	SceneManager.load_scene(self.scene_name)
