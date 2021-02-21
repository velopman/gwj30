extends AudioStreamPlayer

onready var __button_sound: AudioStreamPlayer = $button_pressed


# Lifecycle methods
func _ready() -> void:
	SceneManager.connect("scene_changed", self, "__scene_changed")


# Public Methods
func play_button_sound() -> void:
	self.__button_sound.play()


# Private methods
func __scene_changed(name: String) -> void:
	if playing && name == "main":
		self.playing = false

	if playing:
		if name == "main":
			self.playing = false
	else:
		if name != "main":
			self.playing = true

