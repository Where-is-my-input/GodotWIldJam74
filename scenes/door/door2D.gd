extends Node2D

@export var rotateOcluder:bool = false
@onready var light_occluder_2d: LightOccluder2D = $LightOccluder2D

func _ready() -> void:
	setTile(true if randi_range(0,1) == 1 else false)
	if rotateOcluder:
		light_occluder_2d.rotation_degrees = 90

func setTile(disabled):
	if !disabled:
		get_parent().addNavigation(global_position)
	else:
		get_parent().removeNavigation(global_position)
	light_occluder_2d.visible = disabled
