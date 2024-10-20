extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var a2DKick: Area2D = $Kick
@onready var kickHitbox: CollisionShape2D = $Kick/KickHitbox
@onready var hurtbox: CollisionShape2D = $hurtbox

var controlsEnabled:bool = true

const SPEED = 300.0
var dragY = false
var dragX = false
var kick = false
var kickTimer = 0
var facingY = false
var facingX = false
var direction
var directionY

func _on_ready():
	kickHitbox.set_deferred("disabled", true)
	kickHitbox.disabled = true
	
func _on_init():
	kickHitbox.init()

func _physics_process(delta):
	if !kick && kickTimer == 0 && controlsEnabled:
		kick = Input.is_action_just_pressed("interact")
		direction = Input.get_axis("ui_left", "ui_right")
		directionY = Input.get_axis("ui_up", "ui_down")
	else:
		if kickTimer > 0:
			kickTimer -= 1
		if kickTimer == 0:
			kickHitbox.set_deferred("Disabled", true)
			kickHitbox.disabled = true
			kick = false
		direction = 0
		directionY = 0
		
	if kick && kickTimer == 0:
		kickHitbox.set_deferred("Disabled", false)
		kickHitbox.disabled = false
		kickTimer = 35
	animate(direction,directionY)
	
	if !dragY:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	if !dragX:
		if directionY:
			velocity.y = directionY * SPEED
		else:
			velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	#for i in get_slide_collision_count():
		#var collision = get_slide_collision(i)
		#print("Why -: ", collision)

func animate(X,Y):
	if Y > 0: 
		sprite.play("Down")
		facingX = true
		facingY = true
	if Y < 0: 
		sprite.play("Up")
		facingX = true
		facingY = false
	if X > 0: 
		sprite.play("Right")
		facingX = false
		facingY = false
	if X < 0: 
		sprite.play("Left")
		facingX = false
		facingY = true
	if kick:
		if !facingX && !facingY:
			sprite.play("kickRight")
		if !facingX && facingY:
			sprite.play("kickLeft")
	else:
		if (X == 0 && Y == 0) && !sprite.animation.begins_with("Idle"):
			if !facingX && !facingY:
				sprite.play("IdleRight")
			if facingX && facingY:
				sprite.play("IdleDown")
			if facingX && !facingY:
				sprite.play("IdleUp")
			if !facingX && facingY:
				sprite.play("IdleLeft")


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		print(body)
		body.velocity.x = 0
		body.velocity.y = 0

func enableControls(v = true):
	controlsEnabled = v
