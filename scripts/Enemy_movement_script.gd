extends CharacterBody2D

@export var speed : float = 100.0
var center_node

func _ready():
	center_node = get_parent().get_parent().get_node("Target_node")

func _physics_process(delta: float):
	velocity = (center_node.position - position).normalized()
	move_and_slide()
