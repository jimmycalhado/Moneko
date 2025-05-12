extends AnimatedSprite2D

func _ready():
	$Area2D.body_entered.connect(on_body_entered)
	
func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var player: Player = body
		queue_free()
