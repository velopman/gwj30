extends Control

onready var __button_close: TextureButton = $pause_menu/button_close
onready var __button_pause: TextureButton = $button_pause
onready var __menu: TextureRect = $pause_menu
onready var __tree = self.get_tree()

var __paused: bool = false

func _ready() -> void:
	self.__button_pause.connect("pressed", self, "__pause", [true])
	self.__button_close.connect("pressed", self, "__pause", [false])

func __pause(value: bool) -> void:
	MenuMusic.play_button_sound()
	self.__menu.visible = value
	self.__button_pause.visible = !value
	self.__tree.paused = value

	if value:
		self.mouse_filter = Control.MOUSE_FILTER_STOP
	else:
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _exit_tree():
	self.__tree.paused = false
