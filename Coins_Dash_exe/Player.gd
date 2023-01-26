
extends Area2D

signal pickup
signal hurt

export (int) var speed

var velocity = Vector2()
var screensize = Vector2(480, 720)


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
	if velocity.length() >0:
		velocity = velocity.normalized() * speed

func _process(delta: float) -> void:
	get_input()
	position += velocity * delta
	
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)


	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"


func die():
	$AnimatedSprite.animation = "hurt"
	set_process(false)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Player_area_entered(area: Area2D) -> void:
	if area.is_in_group("coins"):
		area.pickup()
#		print("coins pickup")
		emit_signal("pickup")
	if area.is_in_group("obstacles"):
		emit_signal("hurt")
		die()

