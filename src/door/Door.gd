extends Area2D

signal walked_through_door

@export var door_open : bool = false
var area_active = false

@onready var sprite : Sprite2D = get_node("Door1")
@onready var closed_door_collision_shape : CollisionShape2D = get_node("ClosedDoor/ClosedDoorCollisionShape2D")
@onready var audio_stream_player : AudioStreamPlayer = get_node("AudioStreamPlayer")

var door_open_sound = preload("res://assets/audio/door1-open.wav")
var door_close_sound = preload("res://assets/audio/door1-close.wav")

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		door_open = !door_open

		if door_open:
			audio_stream_player.stream = door_open_sound
			audio_stream_player.play()
			closed_door_collision_shape.disabled = true
			sprite.frame = 1
		else:
			audio_stream_player.stream = door_close_sound
			audio_stream_player.play()
			closed_door_collision_shape.disabled = false
			sprite.frame = 0

func _on_area_entered(area):
	area_active = true

func _on_area_exited(area):
	area_active = false

func _on_leave_area_entered(area):
	walked_through_door.emit()
