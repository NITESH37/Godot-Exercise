extends Area2D

var textures = {'coin': 'res://assets/coin.png', 'key_red': 'res://assets/keyRed.png', 'star': 'res://assets/star.png'}
var type


#func _init(_type, pos) -> void:
#	type = _type
#	position = pos


func _ready() -> void:
	$Sprite.texture = load(textures[type])


func pickup():
	$CollisionShape2D.disabled = true
	$Tween.start()


func _on_Tween_tween_comppleted(objects, key):
	queue_free()