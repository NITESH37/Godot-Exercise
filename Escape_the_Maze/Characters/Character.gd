extends Area2D


export (int) var speed

var tile_size = 64
var can_move = true
var facing = 'right'
var moves = {'right': Vector2(1, 0), 'left': Vector2(-1, 0), 'up': Vector2(0, -1), 'down': Vector2(0, 1)}
#onready var raycasts = {'right': $CollisionShape2D/RayCastRight, 'left': $CollisionShape2D/RayCastLeft, 'up': $CollisionShape2D/RayCastUp, 'down': $CollisionShape2D/RayCastDown}


func move_tween(dir):
	$AnimationPlayer.playback_speed = speed
	facing = dir
#	if raycasts[facing].is_colliding():
#		return
#	can_move = false
	$AnimationPlayer.play(facing)
	print("moved start")
	$MoveTween.interpolate_property(self, "position", position, position + moves[dir] * tile_size, 1.0 / speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT )
	$MoveTween.start()


func _on_MoveTween_tween_completed(Objects, key):
	can_move = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
