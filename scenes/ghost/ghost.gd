extends CharacterBody2D

@export var player:CharacterBody2D = null
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@export var SPEED:int = 250
@export var wanderPoints:Node = null
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var playerPreviousPosition = null

var target:Node2D = null

			#navigation_agent_2d.target_position = goTo.global_position
			#var targetPosition = navigation_agent_2d.get_next_path_position()

func _physics_process(delta: float) -> void:
	if player != null:
		if !testFinalPos():
			player = null
			playerPreviousPosition = null
		else:
			navigation_agent_2d.target_position = player.global_position
	elif playerPreviousPosition == null:
		if target == null:
			getNextWanderTarget()
		else:
			navigation_agent_2d.target_position = target.global_position
	else:
		var previousTarget = navigation_agent_2d.target_position
		navigation_agent_2d.target_position = playerPreviousPosition
		if !testFinalPos(): 
			navigation_agent_2d.target_position = previousTarget
			if !testFinalPos():
				global_position = previousTarget

	var targetPosition = navigation_agent_2d.get_next_path_position()
	#if targetPosition == global_position: target = null
	
	var direction = global_position.direction_to(targetPosition)
	
	setAnimation(direction)
	
	#velocity = Vector2(move_toward(velocity.x, targetPosition.x, SPEED), move_toward(velocity.y, targetPosition.y, SPEED))

	#velocity = Vector2(SPEED * direction.x, SPEED * direction.y)
	velocity = direction * SPEED

	move_and_slide()

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		playerPreviousPosition = player.global_position

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerPreviousPosition = body.global_position
		player = null

func _on_navigation_agent_2d_target_reached() -> void:
	playerPreviousPosition = null
	getNextWanderTarget()

func getNextWanderTarget():
	print("Target reached: ", target)
	target = wanderPoints.getNextTarget()
	navigation_agent_2d.target_position = target.global_position
	print("New target: ", target)
	if !testFinalPos():
		global_position = target.global_position

func testFinalPos():
	var finalPos = navigation_agent_2d.get_final_position()
	var distance = finalPos - navigation_agent_2d.target_position
	if abs(distance.x) > 64 || abs(distance.y) > 64:
		return false
	return true

func _on_hit_area_body_entered(body) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://scenes/video/video.tscn")

func setAnimation(direction):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite_2d.play("Right")
		else:
			animated_sprite_2d.play("Left")
	else:
		if direction.y < 0:
			animated_sprite_2d.play("Up")
		else:
			animated_sprite_2d.play("Down")


func _on_audio_stream_player_2d_finished() -> void:
	await get_tree().create_timer(randi_range(0, 5)).timeout
	audio_stream_player_2d.play()
