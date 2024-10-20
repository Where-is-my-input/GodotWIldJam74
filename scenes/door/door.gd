extends StaticBody2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
#@onready var navigation_obstacle_2d: NavigationObstacle2D = $"../NavigationRegion2D/NavigationObstacle2D"
@onready var sfx: AudioStreamPlayer2D = $"../sfx"


func _on_a_2d_interact_area_entered(area: Area2D) -> void:
	#collision_shape_2d.disabled = !collision_shape_2d.disabled
	#navigation_obstacle_2d.set_carve_navigation_mesh(!collision_shape_2d.disabled)
	collision_shape_2d.set_deferred("disabled", !collision_shape_2d.disabled)
	get_parent().setTile(collision_shape_2d.disabled)
	sfx.play()
