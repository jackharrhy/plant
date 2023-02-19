extends Node2D

signal scene_change(scene_name, arg)

var player_scene = preload("res://src/player/Player.tscn")
var player_instance

func create_player(location):
	player_instance = player_scene.instantiate()
	player_instance.position = location
	player_instance.emit_signal("camera_bounds_update", 0, 768)
	add_child(player_instance)

func make_bed_no_player():
	var bed = $Bed
	bed.get_node("Bed1").frame = 0
	bed.player_sleeping = false
	bed.area_active = false

func init(arg : String):
	match arg:
		"door":
			create_player($PlayerDoorLocation.position)
			make_bed_no_player()
			$Door.open_door(false)
		"bed":
			# scene is already setup for bed
			pass

func _on_bed_create_player():
	create_player($PlayerLocation.position)

func _on_bed_remove_player():
	if player_instance:
		remove_child(player_instance)

func _on_door_walked_through_door():
	scene_change.emit("living-room", "left")
