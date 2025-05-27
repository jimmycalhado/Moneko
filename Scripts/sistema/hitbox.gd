extends Area2D

@export var smoke_scene: PackedScene  # arraste sua cena de fumaça aqui no Inspetor

func _on_body_entered(body):
	if body.is_in_group("player"):
		# Instancia a fumaça
		var smoke = smoke_scene.instantiate()
		smoke.global_position = global_position

		# Define o inimigo como dono da fumaça
		smoke.set_owner(owner)

		# Adiciona a fumaça à cena
		get_tree().current_scene.add_child(smoke)

		# Esconde o inimigo antes da animação terminar (opcional)
		owner.queue_free()

		# Dá um impulso no jogador
		body.velocity.y = body.jump_velocity / 2

		
