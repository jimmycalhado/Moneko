class_name Player
extends CharacterBody2D

const jump_velocity = -400.0

@onready var sprite: Sprite2D = $moneko
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var ray_right: RayCast2D = $Ray_right
@onready var ray_left: RayCast2D = $Ray_left
@onready var hit_audio: AudioStreamPlayer2D = $hit
@onready var game_over_audio: AudioStreamPlayer2D = $game_over

@export var smoke_scene: PackedScene
@export var speed: int = 3
@export_range(0, 1) var lerp_factor = 0.15
@export var max_vida:int = 3

signal player_has_died()

var knockback_power := 20
var knockback_vector:= Vector2.ZERO
var jumpping: bool = false
var running: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var vivo = true
		
func _ready():
	Global.set("Player",self)
	var direcao = position.x
	direcao = Global.position_player
	GameManage.player = self 

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
					
		if knockback_vector != Vector2.ZERO:
			velocity = knockback_vector
		for platforms in get_slide_collision_count():
			var collision = get_slide_collision(platforms)
			if collision.get_collider().has_method("has_collided_with"):
				collision.get_collider().has_collided_with(collision, self)
			
		move_and_slide()
		rotate_sprite()

func rotate_sprite() -> void:
	# Girar sprite
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true


func _on_hut_body_entered(body: Node2D) -> void:
	var knockback = Vector2((global_position.x - body.global_position.x) * knockback_power, -200)
	take_damage(knockback)

func take_damage(knockback_force := Vector2.ZERO, duration :=0.25):
	if GameManage.vida > 0:
		GameManage.vida -= 1
		hit_audio.play()
		
	elif GameManage.vida <= 0:
		die()
	
	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		sprite.modulate = Color(1, 0, 0, 0.6)
		knockback_tween.parallel().tween_property(sprite, "modulate", Color(1,1,1,1), duration)
	
func _on_timer_timeout():
	get_tree().reload_current_scene()

	pass # Replace with function body.


func _on_hut_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		area.queue_free()
		take_damage(Vector2(0, -300))

	if area.is_in_group("espinho"):
		take_damage(Vector2(0, -300))

func handle_death_zone():
	visible = false
	set_physics_process(false)
	
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	GameManage._reset()
	visible = true
	set_physics_process(true)
	
func die():
	vivo = false
	game_over_audio.play()

	# Instancia fumaça
	var smoke = smoke_scene.instantiate()
	smoke.global_position = global_position
	smoke.set_owner(self)
	get_tree().current_scene.add_child(smoke)

	# Esconde o player, mas não remove ainda
	hide()
	set_physics_process(false)
	emit_signal("player_has_died")
