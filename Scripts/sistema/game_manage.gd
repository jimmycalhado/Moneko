extends Node

var player: Player
var player_position: Vector2

var vida := 3
var carrot_counter: int = 0
var carrotgold_counter: int = 0

func _reset():
	carrot_counter = 0;
	carrotgold_counter = 0;
	vida = 3
	
	
