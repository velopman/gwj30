extends AnimatedSprite

export(Texture) var patch_normal = null
export(Texture) var patch_hover = null
export(Texture) var patch_success = null

const PATCH_POSTIION_END: Vector2 = Vector2(32.0, 10.0)

onready var __timer: Timer = $timer
onready var __patch: Sprite = $patch
var __patch_postion_start: Vector2 = Vector2.ZERO

var __following: bool = false
var __over: bool = false
var __near: bool = false


func _ready() -> void:
	self.play("leaking")

	self.__patch_postion_start = Vector2(
		randi() % 150 - 75,
		randi() % 20 - 75
	)

	self.__patch.position = self.__patch_postion_start


func _process(delta: float) -> void:
	if self.__following:
		var distance = (self.get_local_mouse_position() - self.PATCH_POSTIION_END).length()
		if distance < 20.0:
			self.__near = true
			self.__patch.texture = self.patch_success
		else:
			self.__near = false
			self.__patch.texture = self.patch_hover


	if self.__over && Input.is_action_pressed("pressed"):
		self.__patch.position = self.get_local_mouse_position()
		self.__following = true
	elif Input.is_action_just_released("pressed"):
		self.__following = false
		if self.__near:
			self.play("fixed")
			self.__patch.visible = false

			self.__timer.start(0.5)
			yield(self.__timer, "timeout")

			Event.emit_signal("unblock_finished")
			self.call_deferred("queue_free")
		else:
			self.__following = false
			self.__patch.texture = self.patch_normal
			self.__patch.position = self.__patch_postion_start


func _on_patch_mouse_entered():
	self.__patch.texture = self.patch_hover
	self.__over = true


func _on_patch_mouse_exited():
	self.__patch.texture = self.patch_normal
	self.__over = false || self.__following
