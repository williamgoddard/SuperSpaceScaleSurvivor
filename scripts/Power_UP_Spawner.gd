extends Node2D

signal star_collected()

@export var power_up_scene: PackedScene
@export var centre_node: Node2D
@export var star_collector_node: Node2D

func _ready():
	$Timer.start()
	pass


func _on_timer_timeout():
	var power_up = power_up_scene.instantiate()
	power_up.centre_node = centre_node
	power_up.star_collector_node = star_collector_node
	power_up.star_collected.connect(_on_star_collected)
	print("timer timeout")
	add_child(power_up)

func _on_star_collected():
	star_collected.emit()
