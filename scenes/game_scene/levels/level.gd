extends Node
@onready var minigames: Node = $minigames
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

signal level_won
signal level_lost

var minigamesCompleted = 0

func _ready() -> void:
	for c in minigames.get_children():
		c.connect("minigameCompleted", minigameCompleted)

func _on_lose_button_pressed():
	emit_signal("level_lost")

func _on_win_button_pressed():
	emit_signal("level_won")

func minigameCompleted():
	minigamesCompleted += 1
	deleteOneVoid()

func deleteOneVoid():
	canvas_layer.get_child(0).queue_free()

func _on_audio_stream_player_finished() -> void:
	audio_stream_player.play()
