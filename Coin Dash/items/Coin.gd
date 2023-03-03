extends Area2D

var screensize

func _on_Coin_area_entered(area):
	if area.is_in_group("obstacles"):
		position = Vector2(rand_range(0, position.x), rand_range(0, position.y))

func pickup():
	queue_free()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered",self, "_on_Coin_area_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
