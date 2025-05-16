extends Node

var player: Player
var player_position: Vector2

var carrot_counter: int = 0

func _reset():
	carrot_counter = 0
	player.vida = 3
