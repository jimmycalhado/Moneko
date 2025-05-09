extends CharacterBody2D

@export var speed: float = 100.0 
@export var detection_range: float = 500.0  

var moving: bool = false  
var direction: Vector2 = Vector2.ZERO  

func _process(delta):
	if moving:
		velocity = direction * speed
		move_and_slide()

func _on_DetectionArea_body_entered(body):
	if body.is_in_group("player") and not moving:
		moving = true
		direction = (body.global_position - global_position).normalized() 

func _on_DetectionArea_body_exited(body):
	pass  

func _physics_process(delta):
	pass  
