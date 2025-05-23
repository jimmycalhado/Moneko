extends CanvasLayer

@onready var carrot_label: Label = $"quantidade de cenouras/Label"
@onready var vida_label: Label = $"vida/Label"
@onready var animation: AnimationPlayer = $"gold-cenoura/AnimationPlayer"
@onready var frame1: Sprite2D = $"gold-cenoura/cenoura 1"
@onready var frame2: Sprite2D = $"gold-cenoura/cenoura 2"
@onready var frame3: Sprite2D = $"gold-cenoura/cenoura 3"

var player = Player


func _process(delta:float):
	carrot_label.text = str(GameManage.carrot_counter);
	vida_label.text = str(GameManage.vida);
	if GameManage.carrotgold_counter == 1:
		frame1.set_frame(0);
	if GameManage.carrotgold_counter == 2:
		frame2.set_frame(0);
	if GameManage.carrotgold_counter == 3:
		frame3.set_frame(0);
