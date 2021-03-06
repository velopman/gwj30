extends Node2D


const EVENT_COOLDOWN_INITIAL: float = 5.0
const EVENT_FREQUENCY_INITIAL: float = 5.0

export (AudioStreamOGGVorbis) var music_normal = null
export (AudioStreamOGGVorbis) var music_tense = null


onready var __blockables: Array = self.get_tree().get_nodes_in_group("blockable")
onready var __heart = $human/heart
onready var __minigames: Array = $mini_games.get_children()
onready var __music: AudioStreamPlayer = $music
onready var __success_audio: AudioStreamPlayer = $success
onready var __timer: Timer = $timer
onready var __end_game: Control = $menu_container/end
onready var __score_output: TileMap = $score
onready var __score_final_output: TileMap = $menu_container/end/final_score

var __event_cooldown: float = self.EVENT_COOLDOWN_INITIAL
var __event_frequency: float = self.EVENT_FREQUENCY_INITIAL

var __started: bool

var __score: int = 0


# Lifecycle methods
func _ready() -> void:
	randomize()
	self.__start()

	Event.connect("unblock_finished", self.__success_audio, "play")
	Event.connect("limb_died", self, "__limb_died")

	self.__music.stream = self.music_tense
	self.__music.play()


func _process(delta: float) -> void:
	$text.text = "started: %s\ncooldown: %f\nfrequency: %f\nscore: %d" % [
		self.__started,
		self.__event_cooldown,
		self.__event_frequency,
		self.__score
	]

	if !self.__started:
		return

	if self.__event_cooldown != 0.0:
		self.__event_cooldown = max(0.0, self.__event_cooldown - delta)
	elif randi() % 20 == 0:
		self.__trigger_event()

	self.__event_frequency = max(0.0, self.__event_frequency - delta * 0.01)


# Private methods
func __limb_died() -> void:
	match self.__heart.limb_count():
		0:
			self.__end_game.visible = true
			self.__end_game.mouse_filter = Control.MOUSE_FILTER_STOP
			self.get_tree().paused = true

			var best_score = SettingsManager.get_setting("score/best", 0)
			if self.__score > best_score:
				SettingsManager.set_setting("score/best", self.__score, true)
				best_score = self.__score

			self.__score_final_output.set_text(
				"score:%d\n\n best:%d" % [self.__score, best_score]
			)

func __score() -> void:
	var limb_count: int = self.__heart.limb_count()

	if limb_count == 0:
		return

	self.__score += limb_count
	self.__score_output.set_text("score: %d" % self.__score)

func __start() -> void:
	self.__started = true


	self.__timer.one_shot = false
	self.__timer.start(0.5)
	self.__timer.connect("timeout", self, "__score")


func __trigger_event() -> void:
	if self.__blockables.empty():
		return

	var index = randi() % self.__blockables.size()
	var blockage = self.__blockables[index]

	if blockage.is_blocked():
		return

	blockage.block()
	self.__event_cooldown = self.__event_frequency


