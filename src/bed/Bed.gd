extends Area2D

signal create_player
signal remove_player

@export var player_sleeping : bool = true
var area_active = true

@onready var sprite : Sprite2D = get_node("Bed1")

func _input(event):
	if area_active and event.is_action_pressed("ui_accept"):
		player_sleeping = !player_sleeping

		if player_sleeping:
			remove_player.emit()
			sprite.frame = 1
		else:
			create_player.emit()
			sprite.frame = 0

func _on_area_entered(area):
	area_active = true

func _on_area_exited(area):
	if !player_sleeping:
		area_active = false
