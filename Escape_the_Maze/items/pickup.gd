extends Area2D

signal coin_pickup

var textures = {'coin': 'res://assets/coin.png', 'key_red': 'res://assets/keyRed.png', 'star': 'res://assets/star.png'}
var type


#func _init(_type, pos) -> void:
#	type = _type
#	position = pos


func _ready() -> void:
	$Sprite.texture = load(textures[type])


func pickup():
	match type:
		'coin':
			emit_signal('coin_pickup', 1)
	$CollisionShape2D.disabled = true
	$Tween.start()


func _on_Tween_tween_comppleted(objects, key):
	queue_free()
