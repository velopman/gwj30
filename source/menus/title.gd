extends AnimatedSprite


onready var __timer = $timer

func _ready() -> void:
	self.connect("animation_finished", self, "play", ["normal"])

	self.__timer.one_shot = false
	self.__timer.connect("timeout", self, "play", ["pump"])
	self.__timer.start(2.0)
