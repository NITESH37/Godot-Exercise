extends CanvasLayer


signal start_game
onready var start_btn = $StartButton


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()


func _on_messageTimer_timeout():
	$MessageLabel.hide()


func _on_StartButton_pressed():
	$MessageLabel.hide()
	$StartButton.hide()
	emit_signal("start_game")


func show_game_over():
	$MessageLabel.show()
	$StartButton.show()
	$ScoreLabel.show()



func _ready() -> void:
	start_btn.connect("pressed",self, "_on_StartButton_pressed")  #button event listner

