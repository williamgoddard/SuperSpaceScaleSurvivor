extends Node2D

@onready var seesaw_arm_right := $SeesawArmRight
@onready var seesaw_arm_left := $SeesawArmLeft

@export var length := 10:
	set(value):
		if value < 0:
			value = 0
		elif value > 20:
			value = 20
		else:
			length = value
		seesaw_arm_right.length = length
		seesaw_arm_left.length = length
		
func _increase_length():
	length += 1
	
func _decrease_length():
	length -= 1
