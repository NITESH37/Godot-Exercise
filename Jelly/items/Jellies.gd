extends Area2D


export var jelly_color = "yellow"
export var jelly_group : String
var screensize



func _ready() -> void:
	pass
	$AnimatedSprite.animation = jelly_color
#	add_to_group("jellies")
#	get_tree().get_nodes_in_group("jellies")
#	print(get_tree())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
