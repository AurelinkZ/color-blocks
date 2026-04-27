# Audio manager (autoload)
extends Node

var pop_sound: AudioStreamPlayer2D
var hover_sound: AudioStreamPlayer2D

func _ready() -> void:
	pop_sound = AudioStreamPlayer2D.new()
	hover_sound = AudioStreamPlayer2D.new()
	pop_sound.stream = preload("res://SFX/pop_sound.wav")
	hover_sound.stream = preload("res://SFX/hover_sound.wav")
	add_child(pop_sound)
	add_child(hover_sound)

func play_pop(scaled_pitch: float) -> void:
	pop_sound.pitch_scale = scaled_pitch
	pop_sound.play()

func play_hover() ->void:
	hover_sound.play()
