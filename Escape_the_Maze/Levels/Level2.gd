extends Node2D


export (PackedScene) var Enemy 
export (PackedScene) var Pickup

onready var items = $Items
var doors = []


func _ready() -> void:
	randomize()
	$Items.hide()
	set_camera_limits()
	var door_id = $Walls.tile_set.find_tile_by_name('door_red')
	for cell in $Walls.get_used_cells_by_id(door_id):
		doors.append(cell)
#	spawn_items()
	$Player.connect('dead', self, 'game_over')
	$Player.connect('grabbed_key', self, '_on_Player_grabbed_key')
	$Player.connect('win', self, '_on_Player_win')


func set_camera_limits():
	var map_size = $Ground.get_used_rect()
	var cell_size = $Ground.cell_size
	$Player/Camera2D.limit_left = map_size.position.x * cell_size.x
	$Player/Camera2D.limit_top = map_size.position.y * cell_size.y
	$Player/Camera2D.limit_right = map_size.position.x * cell_size.x
	$Player/Camera2D.limit_bottom = map_size.position.y * cell_size.y


func spawn_items():
	for cell in items.get_used_cells():
		var id = items.get_cellv(cell)
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell) + items.cell_size/2
		match type:
			'slime_spawn':
				var s = Enemy.instance()
				s.position = pos
				s.tile_size = items.cell_size
				add_child(s)
			'player_spawn':
				$Player.position = pos
				$Player.tile_size = items.cell_size
			'coin', 'key_red', 'star':
				var pickup = Pickup.instance() as Area2D
				pickup.position = pos
				pickup.type = type
				pickup.init(type, pos)
				add_child(pickup)

func game_over():
	pass


func _on_Player_win():
	pass


func _on_Player_grabbed_key():
	for cell in doors:
		$Walls.set_cellv(cell, -1)



# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
