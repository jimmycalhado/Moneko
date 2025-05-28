extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player") && body.has_method("take_damage"):
		body.take_damage(Vector2(0, -300))
