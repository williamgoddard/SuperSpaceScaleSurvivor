extends Node2D

@onready var game = $".."

signal enemy_died()

@export  var enemy_scene : PackedScene
@export var spawn_radius : float = 200.0
@export var target_node : Node2D
@export var kill_node : Node2D
const POWER_UP = preload("res://scene/power_up.tscn")
var enemy
func _ready():
	pass

func spawn_enemy():
	enemy = enemy_scene.instantiate()
	enemy.enemy_died.connect(_on_enemy_death)
	enemy.position = random_point_on_circle(spawn_radius)
	enemy.set_name('Enemy '+ str(get_child_count()+1))
	enemy.target_node = target_node
	enemy.kill_node = kill_node
	if randf() < 0.5: #flip randomply
		enemy.scale.x *= -1
		enemy.flipped = true
	#enemy.scale = randf_range(1,1.5)
	enemy.game = game
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

func _on_enemy_death():
	enemy_died.emit()


func _on_spawn_power_up_pressed():
	POWER_UP.instantiate()
	pass # Replace with function body.
