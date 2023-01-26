extends CanvasLayer


signal start_game

#func update_score(value):
#	$ScoreLabel.text = str(value)
	

#func update_timer(value):
#	$TimeLabel.text = str(value)


func show_message(text):
	$MessageLevel.text = text
	$MessageLevel.show()
#	$MessageTimer.start()
	
	
func _on_messageTimer_Timeout():
	$MessageLevel.hide()
	

func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLevel.hide()
	emit_signal("start_game")
	

func show_game_over():
	show_message("Game Over")
#	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLevel.text = "Coin Dash! "
	$MessageLevel.show()

