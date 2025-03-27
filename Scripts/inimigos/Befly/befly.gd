extends CharacterBody2D

@export var speed: float = 100.0 
@export var detection_range: float = 200.0 

var player: Node2D = null  
var chasing: bool = false  

@onready var raycast = $RayCast2D  

func _process(delta):
	if player and chasing:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_DetectionArea_body_entered(body):
	if body.is_in_group("player"):
		player = body
		chasing = true

func _on_DetectionArea_body_exited(body):
	if body == player:
		chasing = false
		player = null

func _physics_process(delta):
	if player and chasing:
		raycast.target_position = player.global_position - global_position
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			chasing = false  
