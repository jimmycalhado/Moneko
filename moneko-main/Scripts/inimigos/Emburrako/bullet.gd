extends Area2D

var shoot_speed = -100
var direction_vector = Vector2.UP

func _physics_process(delta: float) -> void:
	translate(direction_vector.normalized() * shoot_speed * delta)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
