extends Node2D

@onready var current_scene = $Room

func _ready() -> void:
	$Room.connect("scene_change", Callable(self, "change_scene"))

func change_scene(scene: String, argument: String):
	var next_scene = load("res://src/scenes/" + scene + ".tscn").instantiate()
	add_child(next_scene)
	next_scene.connect("scene_change", Callable(self, "change_scene"))

	current_scene.queue_free()
	current_scene = next_scene
	next_scene.init(argument)
