extends Node2D

signal scene_change(scene_name, arg)

func init(argument):
	$Player.emit_signal("camera_bounds_update", 0, $FarRightSide.position.x)
	match argument:
		"left":
			# TODO init stuff based on entering from the left
			pass
		"right":
			# TODO init stuff based on entering from the right
			pass

func _on_room_door_walked_through_door():
	scene_change.emit("room1", "door")
