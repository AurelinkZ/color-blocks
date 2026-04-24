extends Control

signal next_level
signal restart_after_win

func _on_next_level_pressed() -> void:
	next_level.emit()

func _on_restart_pressed() -> void:
	restart_after_win.emit()
