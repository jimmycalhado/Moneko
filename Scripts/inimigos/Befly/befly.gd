extends CharacterBody2D

@export var speed: float = 250.0
@export var direction: Vector2 = Vector2.LEFT  # pode ser LEFT ou RIGHT, etc.

@onready var Player = Global.get("player")

var activated: bool = false

func _on_player_detected(body):
	if body.is_in_group("player"):
		activated = true
		look_at(body.global_position)


func _physics_process(delta):
	if activated:
		velocity.x = direction.normalized().x * speed
	else:
		velocity.x = 0

	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		activated = true
		direction = (body.global_position - global_position).normalized()
