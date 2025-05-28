extends AnimatableBody2D

@onready var anime:= $anime as AnimationPlayer

var velocity:= Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_triggered:= false

func _ready() -> void:
	set_physics_process(false)

func _physics_process(delta: float):
	velocity.y += gravity * delta
	position += velocity * delta
	
func has_collided_with(collision: KinematicCollision2D,collider: CharacterBody2D):
	if !is_triggered:
		is_triggered = true
		anime.play("shake")
		velocity = Vector2.ZERO


func _on_anime_animation_finished(anim_name: StringName) -> void:
	set_physics_process(true)
