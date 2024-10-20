extends Node2D

@export var rotateOcluder:bool = false
@onready var light_occluder_2d: LightOccluder2D = $LightOccluder2D
@onready var sprite_2d: Sprite2D = $door/Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $door/CollisionShape2D

func _ready() -> void:
	var disabled = true if randi_range(0,1) == 1 else false
	collision_shape_2d.set_deferred("disabled", !disabled)
	setTile(disabled)
	if rotateOcluder:
		light_occluder_2d.rotation_degrees = 90

func setTile(disabled):
	if !disabled:
		get_parent().addNavigation(global_position)
	else:
		get_parent().removeNavigation(global_position)
	light_occluder_2d.visible = disabled
	sprite_2d.visible = disabled
