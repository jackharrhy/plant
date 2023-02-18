extends CharacterBody2D

@export var speed: int = 200

@onready var sprite = get_node("PlayerSprite")
@onready var animation_player = get_node("AnimationPlayer")

func _physics_process(delta):
	var horizontal_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = horizontal_direction * speed

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.get_normal())

	if is_zero_approx(velocity.x):
		animation_player.play("Idle")
	else:
		animation_player.play("Walking")

	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false
