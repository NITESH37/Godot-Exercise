extends Node2D

export (PackedScene) var coin_scene = preload("res://Coin.tscn")
export (int) var playtime = 20

var level : int
var score : int
var time_left: int
onready var screensize : Vector2 = get_viewport().get_visible_rect().size
var shapedistance = Vector2(50, 50)
var playing := false


func _ready() -> void:
	randomize()
	screensize -=  shapedistance
	$Player.screensize = screensize
	$Player.hide()
#	$HUD.update_score(score)
#	$HUD.update_timer(playtime)
	
#	connecting signals
	$Player.connect("pickup", self, "update_score")
	$HUD.connect("start_game", self, "new_game")


func update_score():
	score += 1
	$HUD/ScoreLabel.text = str(score)
	$GameTimer.wait_time += 5


func new_game():
	playing = true
	level = 1
	score = 0
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start(playtime)
	spawn_coins()


func spawn_coins():
	for i in range(4 + level):
		var coin = coin_scene.instance()
		$CoinContainer.add_child(coin)
		coin.screensize = screensize
		coin.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))


func _process(delta: float) -> void:
	if playing and $CoinContainer.get_child_count() == 0:
		level += 1
#		$GameTimer.wait_time = playtime
		$GameTimer.start(playtime)
		spawn_coins()
	
#	$HUD/ScoreLabel.text = ""
	time_left = int($GameTimer.time_left)
	$HUD/TimeLabel.text = str(time_left)
	




func _on_GameTimer_timeout():
#	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()


func _on_Player_pickup():
	score += 1
	$HUD.update_score(score)


func _on_Player_hurt():
	game_over()

func game_over():
	playing = false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()
	$Player.die() 
