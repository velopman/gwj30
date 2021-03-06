extends Node

signal setting_changed(name, value)

const SETTINGS_PATH = "settings.json"

var __settings: Dictionary = {}
var __settings_default: Dictionary = {
	"volume": {
		"Master": 1.0,
		"Music": 1.0,
		"Sound Effects": 1.0
	},
	"score": {
		"best": 0,
	}
}


func _ready() -> void:
	self.connect("setting_changed", self, "__setting_changed")
	# try loading settings file first
	self.__settings = self.__settings_default

	if FileManager.file_exists(self.SETTINGS_PATH):
		self.__settings = FileManager.load_json(self.SETTINGS_PATH)

		if "sound_effects" in self.__settings["volume"]:
			self.__settings["volume"] = {
				"Master": self.__settings["volume"]["master"],
				"Music": self.__settings["volume"]["music"],
				"Sound Effects": self.__settings["volume"]["sound_effects"],
			}
			self.save_settings()


		Logger.info("Loading settings")
	else:
		FileManager.save_json(self.SETTINGS_PATH, self.__settings)
		Logger.info("Creating settings")


func get_setting(name, default = null):
	var path = name.split("/")
	var location = self.__settings

	for index in range(path.size() - 1):
		var part = path[index]

		if location.has(part):
			location = location.get(part)
		else:
			Logger.warn("Could not get setting '%s'" % name)
			return default

	var setting_name = path[path.size() - 1]
	if location.has(setting_name):
		return location.get(setting_name)
	else:
		Logger.warn("Could not get setting '%s'" % name)
		return default


func save_settings() -> void:
	FileManager.save_json(self.SETTINGS_PATH, self.__settings)


func set_setting(name: String, value, save: bool = false) -> void:
	self.__setting_changed(name, value)
	if save:
		self.save_settings()


func __setting_changed(name: String, value) -> void:
	var path = name.split("/")
	var location = self.__settings

	for index in range(path.size() - 1):
		var part = path[index]

		if location.has(part):
			location = location.get(part)
		else:
			Logger.warn("Could not update setting '%s'" % name)
			return

	var setting_name = path[path.size() - 1]
	if location.has(setting_name):
		location[setting_name] = value
	else:
		Logger.warn("Could not update setting '%s'" % name)
		return
