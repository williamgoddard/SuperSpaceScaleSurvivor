extends Node2D

@onready var seesaw_arm_right := $SeesawArmRight
@onready var seesaw_arm_left := $SeesawArmLeft

@export var length := 10.0:
	set(value):
		if value < 0.5:
			value = 0.5
		elif value > 20:
			value = 20
		else:
			length = value
		var length_floored = floor(length)
		seesaw_arm_right.length = length_floored
		seesaw_arm_left.length = length_floored
		var length_fraction = length - length_floored
		seesaw_arm_right.position.x = -24 + (48 * length_fraction)
		seesaw_arm_left.position.x = 24 - (48 * length_fraction)
		seesaw_arm_left.length = length_floored
