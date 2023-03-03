extends Node2D


export(PackedScene) var coin_scene = preload("res://items/Coin.tscn")
export(PackedScene) var enemy_scene = preload("res://Objects/Enemy.tscn")
export (float) var playtime = 20.0

var level : int # declare the lever variable as integer type
var score : int # declare the score variable as integer type
var time_left : int #declare the variable for time as
var playing = false # declare game will stop
onready var screensize: Vector2 = get_viewport().get_visible_rect().size

# game ready logic
func _ready() -> void:
	randomize()
	$Player.screensize = screensize # assigned  the screen to the player's screensize variable (custom)
	$Player.hide() # hide the player before the game starts
#	$HUD.update_score(score)
	$Player.connect("pickup", self, "update_score") # connected an event to the player's pickup signal(custom) 
	$Player.connect("hurt",self,"_on_player_hurt")  # connected an event to the player's hurt  signal(custom)
	$HUD.connect("start_game", self, "game_start")  # connected an event to the HUD's start_game signal(custom)
	$GameTimer.connect("timeout",self,"_on_GameTimer_timeout") # connect an event to the GameTimer's timeout signal(built-in)


# create Coin Logic
func spawn_coin():
	# this loop genrates amount of coins based on player's current level + 5
	for i in range(5 + level):
		#  created a coin_scene intance into a coin object/node/area2D
		var coin = coin_scene.instance() 
		# add coin as a child of coinContainer
		$CoinContainer.add_child(coin) 
		# assigned a screensize to the coin node 
		coin.screensize = screensize  
		# generate and assigned a random position to the coin node
		coin.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y)) 


func _process(delta: float) -> void:
	# This condition to check that the coin is available in  coin container or not
	if playing and $CoinContainer.get_child_count() == 0:
		level_up()  
	# this is simply to check how much  time to left and assigned into the time left variable
	time_left = int($GameTimer.time_left)  
	$HUD/TimeLabel.text = str(time_left)


# update level logic
func level_up():
	level += 1  # update the level from 1 to level+1
	$GameTimer.start(playtime) # when go to the next level then new time will start
	free_enemies() # call free_enemies function
	spawn_enemy()  # call spawn_enemy function
	spawn_coin()   # call spawn_coin function


# remove enemy logic  
func free_enemies(): 
	for enemy in $EnemyContainer.get_children():
		enemy.queue_free()


#create  Enemy logic
func spawn_enemy():
	for i in range(5):
		var enemy = enemy_scene.instance()
		$EnemyContainer.add_child(enemy)
		enemy.screensize = screensize
		enemy.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))

#start game logic
func game_start():
	playing = true # changed the playing state to true
	level = 1  # reset the level with 1
	score = 0  # reset the score with 0
	$Player.start($PlayerStart.position) # this line, the player will start
	$Player.show()  # this line show the player into the panel or screen
	$GameTimer.start(playtime) # reset the timer value to playtime
	spawn_enemy() # call the function to show the enemy in the screen

#update the score logic
func update_score(): 
	score += 1  # when player collect  a coin score will increase by 1
	$HUD/ScoreLabel.text = str(score) # assigned the score to the  scoreLabel


func _on_GameTimer_timeout():
	if time_left <= 0: # to check the time is over or not if the time is 0 and less then game will be end
		game_over() # call game_over function


func _on_player_pickup(): 
	score += 1   # when the  player pick the coin then score will increase
	$HUD.update_score(score) # pass the score as a parameter of update_score method and add into the HUD


func _on_player_hurt(): # When the player is touch with enemy then the game will end 
	game_over() # call game_over function

#game over Logic
func game_over():   
	playing = false  # if game touch with enemy and time is less 1 then game will stop
	$GameTimer.stop() # if game will stop then time will aslo stop
	for coin in $CoinContainer.get_children():  #
		coin.queue_free()
	$HUD.show_game_over() # 
	$Player.die()  # assgined to player die
