extends CanvasLayer

@onready var resumeBtn =  $Menu_container/resumeBtn

func _ready():
	visible = false

func  _process(delta):
	pass
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resumeBtn.grab_focus()

func _on_pause_btn_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_restart_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
