extends CharacterBody2D

var player = null
var dir = 0

@export var speed = 1.5

@onready var sprite: Sprite2D = $Sprite2D

func _process(delta):
	if player:
		dir = (player.global_position - global_position).normalized()
		velocity = speed * 100 * dir
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _physics_process(delta: float) -> void:
	rotate_sprite()

func rotate_sprite() -> void:
	# Girar sprite
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_area_2d_body_exited(body):
	player = null
