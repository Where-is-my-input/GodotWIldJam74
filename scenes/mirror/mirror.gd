extends Node2D


func _on_area_2d_body_entered(body) -> void:
	if body.is_in_group("Player") && get_parent().minigamesCompleted >= 4:
		get_tree().change_scene_to_file("res://scenes/video/ending.tscn")
