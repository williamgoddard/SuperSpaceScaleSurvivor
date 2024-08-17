extends CharacterBody2D

var speed : float = 100.0
@export var center_node : Node2D

func _ready():
	pass

func _physics_process(delta: float):
	# Calculate the direction towards the center_node
	var direction = (center_node.position - position).normalized()
	# Apply speed to the direction
	velocity = direction * speed
	# Use move_and_slide to move the character
	move_and_slide()
