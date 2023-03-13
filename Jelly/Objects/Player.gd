extends Area2D

signal score_pink
signal score_green
signal score_yellow
signal score_black
signal score_red

export (int) var speed = 200

var score: int
var velocity = Vector2()
var screensize = Vector2(1000,580)


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func _process(delta: float) -> void:
	get_input()
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)






func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:



func _on_Player_area_entered(area: Area2D) -> void:
	if area.jelly_color == "pink":
		emit_signal("score_pink")
		area.queue_free()
	if area.jelly_color == "green":
		emit_signal("score_green")
		area.queue_free()
	if area.jelly_color == "yellow":
		emit_signal("score_yellow")
		area.queue_free()
	if area.jelly_color == "black":
		emit_signal("score_black")
		area.queue_free()
	if area.jelly_color == "red":
		emit_signal("score_red")
		area.queue_free()
