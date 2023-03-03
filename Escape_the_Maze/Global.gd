extends Node


var levels = ['res://Levels/level1.tscn','res//Levels/Level2.tscn']
var current_level
var start_screen = 'res://UI/StartScreen.tscn'
var end_screen = 'res://UI/EndScreen.tscn'
var score = 0
var highscore = 0
var score_file = "user:highscore.text"


func new_game():
	current_level  = -1
	next_level()


func game_over():
	get_tree().change_scene(end_screen)


func next_level():
	current_level += 1
	if current_level >= Global.levels.size():
		game_over()
	else:
		get_tree().change_scene(levels[current_level])


func save_score():
	var files = File.new()
	files.open(score_file, File.WRITE)
	files.store_string(str(highscore))
	files.close()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()

func setup():
	var files = File.new()
	if files.file_exists(score_file):
		files.open(score_file, File.READ)
		var content = files.get_as_text()
		highscore = int(content)
		files.close()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
