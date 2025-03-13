extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		owner.queue_free()
		body.velocity.y = body.jump_velocity/2
