extends CharacterBody2D

@export var gravity: float = 900.0
@export var speed: float = 250.0
@export var direction: Vector2 = Vector2.LEFT
@onready var Player = Global.get("player")

var activated: bool = false

func _physics_process(delta):
	if activated:
		velocity.x = direction.normalized().x * speed
	else:
		velocity.x = 0
		
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if not activated and body.is_in_group("player"):
		activated = true
