extends Node2D

signal star_collected()

@export var power_up_scene: PackedScene
@export var centre_node: Node2D
@export var star_collector_node: Node2D

var time_until_next_star := 30.0

func _process(delta):
	time_until_next_star -= delta
	if time_until_next_star <= 0:
		spawn_star()
		time_until_next_star = randf_range(10, 20)

func spawn_star():
	var power_up = power_up_scene.instantiate()
	power_up.centre_node = centre_node
	power_up.star_collector_node = star_collector_node
	power_up.star_collected.connect(_on_star_collected)
	add_child(power_up)

func _on_star_collected():
	star_collected.emit()
