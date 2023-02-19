extends Area2D

signal create_player
signal remove_player

@export var player_sleeping : bool = true
@export var area_active = true
@export var bed_left_yet = false

@onready var sprite : Sprite2D = get_node("Bed1")

@onready var audio_stream_player : AudioStreamPlayer = get_node("AudioStreamPlayer")
var bed_leave_sound = preload("res://assets/audio/bed1-leave.wav")
var bed_enter_sound = preload("res://assets/audio/bed1-enter.wav")

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		player_sleeping = !player_sleeping

		if player_sleeping:
			audio_stream_player.stream = bed_enter_sound
			remove_player.emit()
			sprite.frame = 1
		else:
			audio_stream_player.stream = bed_leave_sound
			create_player.emit()
			sprite.frame = 0

		audio_stream_player.play()

func _on_area_entered(area):
	area_active = true

func _on_area_exited(area):
	if !player_sleeping:
		area_active = false
