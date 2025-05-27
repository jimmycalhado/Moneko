extends CharacterBody2D

<<<<<<< Updated upstream
@export var speed: float = 100.0 
@export var direction: Vector2 = Vector2.LEFT  

var moving: bool = false  

func _process(delta):
	if moving:
		velocity = direction.normalized() * speed
		move_and_slide()

func _on_DetectionArea_body_entered(body):
	if body.is_in_group("player") and not moving:
		moving = true  

func _on_DetectionArea_body_exited(body):
	pass  

func _physics_process(delta):
	pass  

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		moving = true

func _on_area_2d_body_exited(body):
	moving = false
=======
@export var speed: float = 250.0
@export var gravity: float = 980.0

var direction: Vector2 = Vector2.LEFT
var activated: bool = false

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
>>>>>>> Stashed changes
