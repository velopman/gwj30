extends Node2D


const EVENT_COOLDOWN_INITIAL: float = 5.0
const EVENT_FREQUENCY_INITIAL: float = 5.0

onready var __timer: Timer = $timer
onready var __blockages: Array = self.get_tree().get_nodes_in_group("blockage")

var __event_cooldown: float = self.EVENT_COOLDOWN_INITIAL
var __event_frequency: float = self.EVENT_FREQUENCY_INITIAL

var __started: bool


func _ready() -> void:
	randomize()
	self.__start()


func _process(delta: float) -> void:
	$text.text = "started: %s\ncooldown: %f\nfrequency: %f" % [
		self.__started,
		self.__event_cooldown,
		self.__event_frequency
	]

	if !self.__started:
		return

	if self.__event_cooldown != 0.0:
		self.__event_cooldown = max(0.0, self.__event_cooldown - delta)
	elif randi() % 20 == 0:
		self.__trigger_event()

	self.__event_frequency = max(0.0, self.__event_frequency - delta * 0.01)


func __start() -> void:
	# TODO: timer stuff / countdown
	self.__started = true


func __trigger_event() -> void:
	var index = randi() % self.__blockages.size()
	var blockage = self.__blockages[index]

	if blockage.is_blocked():
		return

	blockage.block()
	self.__event_cooldown = self.__event_frequency

