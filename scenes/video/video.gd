extends Node2D


func _on_video_stream_player_finished() -> void:
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/opening/opening_with_logo.tscn")
