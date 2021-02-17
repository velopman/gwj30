extends Node2D

export(Array, PackedScene) var mini_games


func _ready() -> void:
	Event.connect("unblock_started", self, "__start_minigame")


func __start_minigame() -> void:
	var index = randi() % self.mini_games.size()
	var instance = self.mini_games[index].instance()
	self.call_deferred("add_child", instance)
