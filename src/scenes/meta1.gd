extends Node2D

func timeout(seconds):
	await get_tree().create_timer(seconds).timeout

func init(arg):
	var meta1: Sprite2D = $Meta1

	await timeout(2)
	meta1.scale = Vector2(0.9, 0.9)
	await timeout(2)
	meta1.scale = Vector2(0.8, 0.8)
	await timeout(2)
	meta1.scale = Vector2(0.7, 0.7)
 
	await timeout(2)
	$VideoStreamPlayer.play()

func _on_video_stream_player_finished():
	get_tree().quit()
