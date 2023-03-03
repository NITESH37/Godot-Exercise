extends Area2D


signal hurt
signal pickup

export (int) var speed = 20


var velocity = Vector2()
var screensize = Vector2(480,720)


# Player movment controller
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1;
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func _process(delta: float) -> void:
	#player movment logic
	get_input()   # call get_input function 
	position += velocity * delta  # to set the position per second x-axis and y-axis
	position.x = clamp(position.x, 0, screensize.x) 
	position.y = clamp(position.y, 0, screensize.y)

#player spawn
func start(pos):
	position = pos
	$AnimatedSprite.animation = "idle"
	set_process(true)

#player Death
func die():  
	$AnimatedSprite.animation = "hurt" #if the player collide with enemy then player die
	set_process(false)  # the after set to stop the game


# collision logic
func _on_Player_area_entered(area): # this function check that the coin on area and the player collide then coin pick and hide
	if area.is_in_group("coin"):
		area.pickup()
		emit_signal("pickup")
	if area.is_in_group("obstacles"): # this condition check the player colide with enemy then the player die 
		emit_signal("hurt")
		die()

func _ready() -> void:
	connect("area_entered",self,"_on_Player_area_entered")  # this line is connect  and redy


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
