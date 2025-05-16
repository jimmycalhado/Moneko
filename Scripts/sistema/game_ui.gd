extends CanvasLayer

@onready var carrot_label: Label = $"quantidade de cenouras/Label"
@onready var vida_label: Label = $"vida/Label"
var player = Player


func _process(delta:float):
	carrot_label.text = str(GameManage.carrot_counter)
	vida_label.text = str(GameManage.player.vida)
	
