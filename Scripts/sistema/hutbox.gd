extends Area2D

var body = null

func _on_body_entered(body):
	if body.is_in_group("player"):
		body = Player
		print("dano")
		
func _dano():
	#if body == Player:
	pass	
	
