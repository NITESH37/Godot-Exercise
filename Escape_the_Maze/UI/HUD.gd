extends CanvasLayer


func update_score(vlaue):
	Global.score += value
	$MarginContainer/ScoreLabel.text = str(Global.score)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/ScoreLabel.text = str(Global.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
