extends CharacterBody2D

@export var speed = 1

const jump = -400.0

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D =  $bilu

var running: bool = false
var player = null
var direction = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$detectaplayer.body_entered.connect(on_body_entered)
	animation
	
func _physics_process(delta: float) -> void:
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
		 
	move_and_slide()	
	_animation()
	rotate_sprite()
	return
	
func _animation():
	if velocity.x != 0 :
		pass
	else:
		animation.play("idle")

	rotate_sprite()

func rotate_sprite() -> void:
	# Girar sprite
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false

func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
	return
	
func _on_area_2d_body_exited(body):
	player = null
