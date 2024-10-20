extends Node2D

signal minigameEnd
signal minigameClosed
@onready var sprite_2d: Sprite2D = $CanvasLayer/end/Sprite2D

func _physics_process(delta: float) -> void:
	sprite_2d.rotate(1)

func _on_end_body_entered(body) -> void:
	minigameEnd.emit()
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		minigameClosed.emit()
		queue_free()
