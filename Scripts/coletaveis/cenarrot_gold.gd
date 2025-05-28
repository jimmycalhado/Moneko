extends AnimatedSprite2D

@onready var crunch_audio: AudioStreamPlayer2D = $crunch
@onready var area: Area2D = $Area2D

func _ready():
	area.body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		crunch_audio.play()
		GameManage.carrotgold_counter += 1
		area.set_monitoring(false)  # impede que outro player ative novamente
		hide()  # esconde a cenoura imediatamente

		await crunch_audio.finished
		queue_free()
