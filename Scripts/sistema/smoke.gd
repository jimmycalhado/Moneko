extends Sprite2D

func _ready():
	$AnimationPlayer.play("smoke")
	$AnimationPlayer.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_animation_finished(anim_name):
	if anim_name == "smoke" and owner:
		owner.queue_free()
	queue_free()
