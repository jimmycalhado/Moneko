extends CharacterBody2D

@export var speed = 1

const jump = -400.0

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D =  $bilu
@onready var ground_detector: RayCast2D =  $ground_detector
@onready var player_detector: RayCast2D =  $player_detector2
@onready var spawn_fireball: Marker2D =  $fireball_spawn

var running: bool = false
var player = null
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animation
	
func _physics_process(delta: float) -> void:
	
	if is_on_wall():
		direction *= -1
		sprite.scale.x *= -1
		player_detector.scale.x *= -1

	if not ground_detector.is_colliding():
		direction *= -1
		sprite.scale.x *= -1
		player_detector.scale.x *= -1
		
	velocity.x = speed * direction * 100
	velocity.y += gravity * delta
		 
	move_and_slide()	
	_animation()
	return
	
func _animation():
	if velocity.x != 0 :
		animation.play("run")
	else:
		animation.play("idle")
