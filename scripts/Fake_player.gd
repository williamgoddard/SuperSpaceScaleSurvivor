extends Node2D

@export var actual_player: NodePath
@export var rotation_root: NodePath

var actual_player_node: Node2D
var rotation_root_node: Node2D

func _ready():
	# Initialize node references
	actual_player_node = get_node(actual_player)
	rotation_root_node = get_node(rotation_root)

func _process(delta):
	if actual_player_node and rotation_root_node:
		# Get the global position of the ActualPlayer
		var global_position = actual_player_node.global_position


		var local_position = rotation_root_node.to_local(global_position)

		position = local_position



func update_animation():
	var velocity = actual_player_node.velocity  # Replace with actual way to get velocity
	var is_on_floor = actual_player_node.is_on_floor()  # Replace with actual way to check if on floor
	var facing_right = actual_player_node.facing_right  # Replace with actual way to get facing direction
	
	if is_on_floor:
		if velocity.x == 0:
			
			# Idle animation
			if facing_right:
				$AnimatedSprite2D.play("idle")
			else:
				$AnimatedSprite2D.play("idle")
		else:
			#run animation
			if facing_right:
				$AnimatedSprite2D.play("run_right")
			else:
				$AnimatedSprite2D.play("run_left")
	else:
		if velocity.x == 0 and velocity.y > 0:
			$AnimatedSprite2D.play("jump_idle")
		elif velocity.x > 0  and velocity.y > 0:
			if facing_right:
				$AnimatedSprite2D.play("jump_right")
			else:
				$AnimatedSprite2D.play("jump_left")
		elif velocity.x == 0:
			$AnimatedSprite2D.play("fall_idle")
		else:
			if facing_right:
				$AnimatedSprite2D.play("fall_right")
			else:
				$AnimatedSprite2D.play("fall_left")
