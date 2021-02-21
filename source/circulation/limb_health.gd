class_name LimbHealth extends Sprite

onready var __display: TileMap = $output


func set_health(amount: float) -> void:
	var int_amount = int(amount * 100)
	if int_amount > 0:
		self.__display.set_text("limb: %d%%" % int_amount)
	else:
		self.__display.set_text("limb: lostp")
