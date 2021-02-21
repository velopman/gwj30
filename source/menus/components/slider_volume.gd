extends HSlider


export (String) var display_name = "Volume"
export (String) var controlled_bus = null

onready var label = $label


func _ready() -> void:
	if !self.controlled_bus:
		Logger.warn("Volume slider '%s' does not have a controlled bus." % self.display_name)

	self.value = SettingsManager.get_setting("volume/%s" % self.controlled_bus)
	AudioManager.set_volume(self.controlled_bus, value)

	self.label.text = self.display_name

	self.connect("value_changed", self, "__value_changed")

func __value_changed(value: float) -> void:
	AudioManager.set_volume(self.controlled_bus, value)
