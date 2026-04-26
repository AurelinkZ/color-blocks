extends Node2D

const GAME_SCENE = preload("res://Scenes/main_level_scene.tscn") 

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE.resource_path)
