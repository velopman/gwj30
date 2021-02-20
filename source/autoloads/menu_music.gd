extends AudioStreamPlayer

func _ready() -> void:
	SceneManager.connect("scene_changed", self, "__scene_changed")


func __scene_changed(name: String) -> void:
	if playing && name == "main":
		self.playing = false

	if playing:
		if name == "main":
			self.playing = false
	else:
		if name != "main":
			self.playing = true
