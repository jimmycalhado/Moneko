extends Area2D

@onready var transition = get_parent().get_node("transition")

@export var next_level: String = ""

func _on_body_entered(body) -> void:
	if !next_level == "":
		transition.change_scene(next_level)
	else:
		print("erro")
