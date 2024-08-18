extends Node2D

@export  var enemy_scene : PackedScene
@export var spawn_radius : float = 200.0
@export var target_node : Node2D
@export var kill_node : Node2D
var enemy
func _ready():
	pass

func spawn_enemy():
	enemy = enemy_scene.instantiate()
	enemy.position = random_point_on_circle(spawn_radius)
	enemy.set_name('Enemy '+ str(get_child_count()+1))
	enemy.target_node = target_node
	enemy.kill_node = kill_node
	if randf() < 0.5: #flip randomply
		enemy.scale.x *= -1  
	#enemy.scale = randf_range(1,1.5)
	add_child(enemy)
	enemy.look_at(target_node.position)

func random_point_on_circle(radius: float) -> Vector2:
	var angle = randf() * TAU  # TAU is 2 * PI
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	return Vector2(x, y)


func _on_spawn_enemy_pressed():
	spawn_enemy()
	pass # Replace with function body.
