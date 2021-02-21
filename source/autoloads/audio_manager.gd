extends Node

var __volume_max = {
	# key: bus name
	# value: starting volume
}
var __volume_min: float = -40.0

func _ready() -> void:
	var levels = SettingsManager.get_setting("volume", {})
	for key in levels.keys():
		var index = self.__get_bus_index(key)
		self.__volume_max[key] = AudioServer.get_bus_volume_db(index)
		var value = lerp(self.__volume_min, self.__volume_max[key], levels[key])
		AudioServer.set_bus_volume_db(index, value)


func set_volume(name: String, value: float) -> void:
	var index = self.__get_bus_index(name)

	var volume_db = -INF
	if value > 0.0:
		volume_db = lerp(self.__volume_min, self.__volume_max[name], value)
	AudioServer.set_bus_volume_db(index, volume_db)

	SettingsManager.set_setting("volume/%s" % name, value, true)


func __get_bus_index(name: String) -> int:
	return AudioServer.get_bus_index(name)
