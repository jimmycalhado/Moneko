extends Area2D

var player = Player

func _on_body_entered(body: Node2D) -> void:
	body.handle_death_zone()
