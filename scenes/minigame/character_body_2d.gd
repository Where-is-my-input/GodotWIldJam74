extends CharacterBody2D

const SPEED = 640

var facing = 1

func _physics_process(delta: float) -> void:
	if velocity == Vector2(0,0):
		var direction = Input.get_axis("ui_left", "ui_right")
		var directionY = Input.get_axis("ui_up", "ui_down")
		
		if direction != 0:
			velocity.x = direction * SPEED
			flip(direction)
		else:
			velocity.y = directionY * SPEED
	move_and_slide()

func flip(v):
	if facing != v:
		facing = v
		scale.x *= -1
