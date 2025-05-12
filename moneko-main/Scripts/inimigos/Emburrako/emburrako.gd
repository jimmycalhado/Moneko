extends CharacterBody2D

var facing_left = true

@onready var bullet_instance = preload("res://Scene/personagens/inimigos/Emburrako/bullet.tscn")
@onready var Player = Global.get("player")

func _physics_process(delta: float) -> void:
	_set_animation()
	if Player:
		var distance = Player.global_position.x - self.position.x
		facing_left = true if distance < 0 else false
		
	if facing_left:
		self.scale.x = 1
	else: 
		self.scale.x = -1
		
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
	if facing_left:
		bullet.direction = 1
	else:
		bullet.direction = -1

func _on_detectar_player_body_entered(body: Node2D) -> void:
	$Animation.play("tiro")
	
func _on_detectar_player_body_exited(body: Node2D) -> void:
	$Animation.play("idle")
