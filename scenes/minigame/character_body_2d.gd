extends CharacterBody2D

const SPEED = 640
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var facing = 1

func _physics_process(delta: float) -> void:
	if velocity == Vector2(0,0):
		collision_shape_2d.scale = Vector2(1, 1)
		var direction = Input.get_axis("ui_left", "ui_right")
		var directionY = Input.get_axis("ui_up", "ui_down")
		
		if direction != 0:
			velocity.x = direction * SPEED
			flip(direction)
			collision_shape_2d.scale = Vector2(0.9, 0.9)
		elif directionY != 0:
			velocity.y = directionY * SPEED
			collision_shape_2d.scale = Vector2(0.9, 0.9)
	else:
		collision_shape_2d.scale = Vector2(0.9, 0.9)
	move_and_slide()

func flip(v):
	if facing != v:
		facing = v
		scale.x *= -1
