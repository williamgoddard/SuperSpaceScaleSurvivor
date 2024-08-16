extends Node2D

@onready var tile_map = $TileMap

@export var length := 10:
	set(value):
		if value < 0:
			value = 0
		elif value > 20:
			value = 20
		else:
			length = value
var previous_length := 0

func _physics_process(delta):
	if length > previous_length:
		for i in range(previous_length, length):
			tile_map.set_cell(0, Vector2(i, 0), 0, Vector2(1,0))
		tile_map.set_cell(0, Vector2(length, 0), 0, Vector2(2,0))
		previous_length = length
	elif previous_length > length:
		for i in range(length+1, previous_length+1):
			tile_map.set_cell(0, Vector2(i, 0), -1)
		tile_map.set_cell(0, Vector2(length, 0), 0, Vector2(2,0))
		previous_length = length
