class_name  Player
extends CharacterBody2D

const jump_velocity = -400.0

@onready var sprite: Sprite2D = $moneko
@onready var animation: AnimationPlayer = $AnimationPlayer

@export var speed = 3
@export_range(0, 1) var lerp_factor = 0.15

var jumpping: bool = false
var running: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# gravidade
	if not is_on_floor():
		velocity.y += gravity * delta

	# pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		
	# movimentação pra esquerda e direita
	var direction = Input.get_axis("ui_left", "ui_right")
	var target_velocity = direction * speed * 100
	
	# deslizamento
	velocity.x = lerp(velocity.x, target_velocity,lerp_factor)
	
	# tipo de animação
	if direction:
		running = true
		if running:
			if is_on_floor():
				animation.play("run")
			elif !is_on_floor():
				animation.play("jump")

	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		running = false
		if !running:
			if is_on_floor():
				animation.play("idle")
			elif !is_on_floor():
				animation.play("jump")
	move_and_slide()
	rotate_sprite()

func rotate_sprite() -> void:
	# Girar sprite
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true
