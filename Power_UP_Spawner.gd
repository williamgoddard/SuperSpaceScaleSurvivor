extends Node2D


@export var power_up_scene: PackedScene
@export var centre_node: Node2D

func _ready():
	$Timer.start()
	pass


func _on_timer_timeout():
	var power_up = power_up_scene.instantiate()
	power_up.centre_node = centre_node
	print("timer timeout")
	add_child(power_up)
