class_name Player
extends CharacterBody2D

const jump_velocity = -400.0

@onready var sprite: Sprite2D = $moneko
@onready var animation: AnimationPlayer = $AnimationPlayer


@export var speed: int = 3
@export_range(0, 1) var lerp_factor = 0.15
@export var vida:int = 3
@export var max_vida:int = 3

var jumpping: bool = false
var running: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var vivo = true

func _ready():
	Global.set("Player",self)
	var direcao = position.x
	direcao = Global.position_player

func _physics_process(delta):
	if vivo:
		# gravidade
		if not is_on_floor():
			velocity.y += gravity * delta

		# pulo
		if Input.is_action_just_pressed("pulo") and is_on_floor():
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


func _on_hut_body_entered(body):
	if body.is_in_group("inimigos"):
		vida -= 1
		velocity.y = jump_velocity
		velocity.x =  -1 * jump_velocity
		print("dano")
		if vida == 0:
			vivo = false;
			visible = false
			$Reset.start(0)



func _on_timer_timeout():
	get_tree().reload_current_scene()

	pass # Replace with function body.


func _on_hut_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		area.queue_free()
		vida -= 1
		velocity.y = jump_velocity
		velocity.x =  -1 * jump_velocity
		print("dano")
		if vida == 0:
			vivo = false;
			visible = false
			$Reset.start(0)
