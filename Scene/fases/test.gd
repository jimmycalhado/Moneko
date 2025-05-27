extends Node2D

@onready var player: CharacterBody2D = $Moneko 
@onready var game_over: AudioStreamPlayer2D = $game_over

func _ready() -> void:
	player.player_has_died.connect(reload_game)

func reload_game():	
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
	GameManage._reset()
