extends Node2D

@export var enemy_count : int = 10
@export var spawn_radius : float = 200.0
@export var enemy_scene : PackedScene
@export var target_node : Node2D

func _ready():
	for i in range(enemy_count):
		var enemy = enemy_scene.instance()
		enemy.position = random_point_on_circle(spawn_radius)
		add_child(enemy)
		enemy.look_at(target_node.position)
		
func random_point_on_circle(radius: float) -> Vector2:
	var angle = randf() * TAU 
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	return Vector2(x, y)
