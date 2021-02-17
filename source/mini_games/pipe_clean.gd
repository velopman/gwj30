extends Sprite

const CLEAR_RADIUS: int = 5

onready var __dust: TileMap = $dust
onready var __timer: Timer = $timer

var __finished = false


func _ready() -> void:
	for position in self.__dust.get_used_cells():
		self.__dust.set_cellv(position, randi() % 4)


func _process(delta: float) -> void:
	if self.__finished:
		return

	if Input.is_action_pressed("pressed"):
		var mouse_position = self.__dust.get_local_mouse_position()
		var dust_position = mouse_position / 4.0
		dust_position.x = floor(dust_position.x)
		dust_position.y = floor(dust_position.y)

		for x in range(-self.CLEAR_RADIUS, self.CLEAR_RADIUS):
			for y in range(-self.CLEAR_RADIUS, self.CLEAR_RADIUS):
				var position = dust_position + Vector2(x, y)
				self.__dust.set_cellv(position, self.__dust.INVALID_CELL)

		if self.__dust.get_used_cells().size() == 0:
			self.__finished = true

			self.__timer.start(0.5)
			yield(self.__timer, "timeout")

			Event.emit_signal("unblock_finished")
			self.queue_free()
