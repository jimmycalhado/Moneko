extends Node2D

@onready var player: CharacterBody2D = $Moneko
@onready var animation: AnimationPlayer = $Animation

func _ready() -> void:
	player.vivo = false
	animation.play("cutscene")
	animation.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "cutscene":
		get_tree().change_scene_to_file("res://Scene/fases/fase1.tscn")
