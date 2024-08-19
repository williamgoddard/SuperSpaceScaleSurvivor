extends Node2D

@onready var seesaw_arm_right := $SeesawArmRight
@onready var seesaw_arm_left := $SeesawArmLeft
@onready var tile_map = $TileMap

var destroyed := false

@export var length := 10.0:
	set(value):
		if value < 0.5:
			value = 0.5
		elif value > 20:
			value = 20
		else:
			length = value
		var length_floored = floor(length)
		var length_fraction = length - length_floored
		if not destroyed:
			seesaw_arm_right.length = length_floored
			seesaw_arm_left.length = length_floored
			seesaw_arm_right.position.x = -24 + (48 * length_fraction)
			seesaw_arm_left.position.x = 24 - (48 * length_fraction)
		
func destroy():
	if not destroyed:
		destroyed = true
		seesaw_arm_left.queue_free() 
		seesaw_arm_right.queue_free()
		tile_map.queue_free()
