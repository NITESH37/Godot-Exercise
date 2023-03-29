extends Node2D


export(PackedScene) var jelly_scene = preload("res://items/Jellies.tscn")

var score: int
var level: int
var JellyColor: int
var JellyGround
var playing = false
var time_left: int
export (float) var playtime = 30.0
onready var screensize: Vector2 = get_viewport().get_visible_rect().size


func good_jelly_colors():
	var colors = ["green", "pink", "yellow"]
	var randomValue:int = randi() % colors.size()
	print(colors[randomValue])
	return colors[randomValue]


func bad_jelly_colors():
	var colors = ["red", "black"]
	var randomValue:int = randi() % colors.size()
	print(colors[randomValue])
	return colors[randomValue]


func spawn_goodJelly():
	for i in range(5):
		var good_jelly = jelly_scene.instance()
		good_jelly.jelly_color = good_jelly_colors()
		good_jelly.screensize = screensize
		good_jelly.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
		add_child(good_jelly)


func spawn_badJelly():
	for i in range(5):
		var bad_jelly = jelly_scene.instance()
		bad_jelly.jelly_color = bad_jelly_colors()
		bad_jelly.screensize = screensize
		bad_jelly.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))
		add_child(bad_jelly)

func update_score_pink():
	score += 5
	$HUD/Score.text = str(score)


func update_score_green():
	score += 1
	$HUD/Score.text = str(score)


func update_score_yellow():
	score += 2
	$HUD/Score.text = str(score)


func update_score_black():
	if score > 0:
		score -= 5
		$HUD/Score.text = str(score)
	else:
		game_over()



func update_score_red():
	score -= 10
	$HUD/Score.text = str(score)



func _ready() -> void:
	randomize()
	$Player.hide()
	$Player.connect("score_pink", self, "update_score_pink")
	$Player.connect("score_yellow", self, "update_score_yellow")
	$Player.connect("score_green", self, "update_score_green")
	$Player.connect("score_black", self, "update_score_black")
	$Player.connect("score_red", self, "update_score_red")
	$HUD.connect("start_game", self, "game_start")
	$Timer.connect("timeout", self, "_on_GameTimer_timeout")


func _process(delta: float) -> void:
	time_left = $Timer.time_left
	$HUD/Time.text =  str(time_left)



func game_start():
	playing = true
	score = 0
	$Player.show()
	$Timer.start(playtime)
	spawn_goodJelly()
	spawn_badJelly()



func game_over():
	playing = false
	$Timer.stop()
	$Player.hide()
	$HUD.show_game_over()

#func game_score():
#	if score < 0:
#		game_over()


func _on_GameTimer_timeout(): 
	game_over()


func level_up():
	level += 1
	$Timer.start(playing)
	spawn_badJelly()
	spawn_goodJelly()
