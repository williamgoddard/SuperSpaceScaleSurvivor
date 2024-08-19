extends Node2D

@export var centre_node : Node2D
@export var speed: float = 200.0
@export var large_circle_radius: float = 1000.0
@export var small_circle_radius: float = 500.0
@export var star_collector_node: Node2D

signal star_collected
var direction: Vector2
var large_circle_center: Vector2

func _ready():
	large_circle_center = centre_node.position
	var angle = randf() * TAU
	
	var spawn_position = random_point_on_circle(large_circle_radius) + centre_node.position
	position = spawn_position

	#get random point in smaller circle
	var random_angle = randf() * TAU
	var random_point_in_small_circle = large_circle_center + Vector2(cos(random_angle), sin(random_angle)) * randi_range(0, small_circle_radius)

	# Calculate the direction from the spawn position to the random point
	direction = (random_point_in_small_circle - spawn_position).normalized()

	$Timer.start(large_circle_radius / speed)

func _process(delta):
	# Move the star in the calculated direction
	position += direction * speed * delta
	# Check if the star has exited the larger circle and delete it if it has
	if position.distance_to(large_circle_center) > large_circle_radius:
		queue_free()
		
func random_point_on_circle(radius: float) -> Vector2:
	var angle = randf() * TAU  # TAU is 2 * PI
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	return Vector2(x, y)

func die():
	emit_signal("star_collected")
	queue_free()

func _on_area_2d_body_entered(body):
	if body == star_collector_node:
		die()
