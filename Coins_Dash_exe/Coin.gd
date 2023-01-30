extends Area2D


var screensize

func _on_Coin_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))


func pickup():
	queue_free()


func _ready() -> void:
	connect("area_entered", self, "_on_Coin_area_entered")
