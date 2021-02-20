extends Node2D

export(Array, PackedScene) var mini_games


func _ready() -> void:
	Event.connect("unblock_started", self, "__start_minigame")
	Event.connect("unblock_finished", self, "set_visible", [false])


func __start_minigame() -> void:
	self.global_position = Globals.unblock_position
	self.visible = true
	var index = randi() % self.mini_games.size()
	var instance = self.mini_games[index].instance()
	self.call_deferred("add_child", instance)
