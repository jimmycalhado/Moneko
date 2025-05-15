extends CharacterBody2D

@onready var bullet_instance = preload("res://Scene/personagens/inimigos/Emburrako/bullet.tscn")
@onready var Player = Global.get("player")

func _set_animation():
	var animation = "idle"

	if $detectarPlayer.overlaps_body(Player):
		animation = "tiro"
	else:
		animation = "idle"
		
func shoot():
	var bullet = bullet_instance.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = $spawnBullet.global_position
	bullet.rotation = rotation
	bullet.direction_vector = Vector2.DOWN.rotated(rotation)
	
func _on_detectar_player_body_entered(body: Node2D) -> void:
	$Animation.play("tiro")
	
func _on_detectar_player_body_exited(body: Node2D) -> void:
	$Animation.play("idle")
