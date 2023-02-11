extends "res://Characters/Character.gd"

signal moved
signal grabbed_key
signal win

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up"):
#		print("up is pressed")
		print("up is pressed")
		move_tween("up")
	if Input.is_action_just_pressed("down"):
		move_tween("down")
	if Input.is_action_just_pressed("left"):
		move_tween("left")
	if Input.is_action_just_pressed("right"):
		move_tween("right")
#	if can_move:
#		for dir in moves.keys():
#			if Input.is_action_pressed(dir):
#				if move(dir):
#					emit_signal('moved')

#func _process(delta: float) -> void:
#	if can_move:
#		for dir in moves.keys():
#			if Input.is_action_pressed(dir):
#				if move_tween(dir):
#					emit_signal("moved")



func _on_Player_area_entered(area):
	if area.is_in_group('enemies'):
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
	if area.type == 'key_red':
		emit_signal('grabbed_key')
	if area.type == 'star':
		emit_signal('win')

