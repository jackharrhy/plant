extends Node2D

var player_scene = preload("res://src/player/Player.tscn")

@onready var player_location : Node2D = get_node("PlayerLocation")

var player_instance

func _on_bed_create_player():
	player_instance = player_scene.instantiate()
	player_instance.position = player_location.position
	add_child(player_instance)


func _on_bed_remove_player():
	if player_instance:
		remove_child(player_instance)


func _on_door_walked_through_door():
	assert(get_tree().change_scene_to_file("res://src/scenes/living-room.tscn") == OK)
