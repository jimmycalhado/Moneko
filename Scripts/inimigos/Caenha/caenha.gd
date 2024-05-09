extends CharacterBody2D


@export var speed = 1

const JUMP_VELOCITY = -400.0

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D =  $caenha

var running: bool = false
var player : Player
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Area2D.body_entered.connect(on_body_entered)

func _physics_process(delta: float):
	# Gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Movimentação
	_animation()
	move_and_slide()

func _animation():
	pass

func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("heroi"):
		pass
