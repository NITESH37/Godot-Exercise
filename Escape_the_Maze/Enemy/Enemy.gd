extends "res://Characters/Character.gd"

func _ready() -> void:
	can_move = false
	facing = moves.keys() [randi() % 4]
	yield(get_tree().create_timer(0.5), "timeout")
	can_move = true


func _process(delta: float) -> void:
	if can_move:
		if not move_tween(facing) or randi() % 10 > 5:
			facing = moves.keys() [randi() % 4]

