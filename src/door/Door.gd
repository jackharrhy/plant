extends Area2D

signal walked_through_door

@export var door_open : bool = false
@export var visible_when_open : bool = true
var area_active = false

@onready var sprite : Sprite2D = get_node("Door1")
@onready var closed_door_collision_shape : CollisionShape2D = get_node("ClosedDoor/ClosedDoorCollisionShape2D")
@onready var audio_stream_player : AudioStreamPlayer = get_node("AudioStreamPlayer")

var door_open_sound = preload("res://assets/audio/door1-open.wav")
var door_close_sound = preload("res://assets/audio/door1-close.wav")

func open_door(make_sound, visible):
	if visible:
		sprite.frame = 1
	else:
		sprite.frame = 2

	if make_sound:
		audio_stream_player.stream = door_open_sound
		audio_stream_player.play()
	
	closed_door_collision_shape.set_deferred("disabled", true)

func close_door(make_sound, visible):
	sprite.frame = 0

	if make_sound:
		audio_stream_player.stream = door_close_sound
		audio_stream_player.play()
		
	closed_door_collision_shape.set_deferred("disabled", false)

func handle(make_sound, visible):
	if door_open: open_door(make_sound, visible)
	else: close_door(make_sound, visible)

func _ready():
	handle(false, visible_when_open)

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		door_open = !door_open
		handle(true, visible_when_open)

func _on_area_entered(area):
	area_active = true

func _on_area_exited(area):
	area_active = false

func _on_leave_area_entered(area):
	walked_through_door.emit()
