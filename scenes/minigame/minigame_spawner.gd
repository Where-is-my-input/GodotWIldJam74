extends Node2D

@export var minigame:int = 0
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D

var player = null

signal minigameCompleted

const MINIGAME = preload("res://scenes/minigame/minigame.tscn")
const MINIGAME_1 = preload("res://scenes/minigame/minigame_1.tscn")
const MINIGAME_2 = preload("res://scenes/minigame/minigame_2.tscn")
const MINIGAME_3 = preload("res://scenes/minigame/minigame_3.tscn")

func _physics_process(delta: float) -> void:
	sprite_2d.rotate(-1)

func spawnMinigame():
	if get_child_count() > 3 || !timer.is_stopped(): return
	var spawn = null
	match minigame:
		1:
			spawn = MINIGAME_1.instantiate()
			add_child(spawn)
		2:
			spawn = MINIGAME_2.instantiate()
			add_child(spawn)
		3:
			spawn = MINIGAME_3.instantiate()
			add_child(spawn)
		_:
			spawn = MINIGAME.instantiate()
			add_child(spawn)
	spawn.connect("minigameEnd", completed)
	spawn.connect("minigameClosed", closed)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if !timer.is_stopped(): return
	spawnMinigame()
	player = area.get_parent()
	player.enableControls(false)

func completed():
	minigameCompleted.emit()
	player.enableControls(true)
	queue_free()

func closed():
	timer.start(1)
	player.enableControls(true)
