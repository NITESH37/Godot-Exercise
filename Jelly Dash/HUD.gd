extends CanvasLayer


signal start_game
onready var start_btn = $Start


func show_message(text):
	$Message.text = text
	$Message.show()


func show_game_over():
	$Message.show()
	$Start.show()
	$Score.show()


func _on_messageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$Message.hide()
	$Start.hide()
	$Control/score_panel.hide()
	$Control/timer_panel.hide()
	$Control/Panel.hide()
	emit_signal("start_game")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_btn.connect("pressed",self, "_on_StartButton_pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
