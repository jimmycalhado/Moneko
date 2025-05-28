extends CanvasLayer

@onready var color_rect = $color_rect

func _ready() -> void:
	show_new_scene()

func change_scene(path, delay= 0.5):
	var scene_transition = get_tree().create_tween()
	scene_transition.tween_property(color_rect, "progress", 1.0, 1.0).set_delay(delay)
	await scene_transition.finished
	assert(get_tree().change_scene_to_file(path) == OK)

func show_new_scene():
	var show_transition = get_tree().create_tween()
	show_transition.tween_property(color_rect, "progress", 0.0, 1.0).from(1.0)
		
