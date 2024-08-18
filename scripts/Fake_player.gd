extends Node2D

@export var actual_player: NodePath
@onready var area_2d = $Area2D

var actual_player_node: Node2D

func _ready():
	actual_player_node = get_node(actual_player)

func _process(delta):
	position.x = actual_player_node.position.x - 3000
	position.y = actual_player_node.position.y
	update_animation()



func update_animation():
	var velocity = actual_player_node.velocity  
	var is_on_floor = actual_player_node.is_on_floor()  
	var facing_right = actual_player_node.facing_right
	var is_ground_pounding = actual_player_node.is_ground_pounding
	var is_dashing = actual_player_node.is_dashing
	var dash_direction = actual_player_node.dash_direction
	var is_recovering = actual_player_node.is_recovering
	
	if is_ground_pounding:
		$AnimatedSprite2D.play("ground_pound")
	elif is_recovering:
		$AnimatedSprite2D.play("ground_pound_recovery")
	elif is_dashing:
		if dash_direction > 0:
			$AnimatedSprite2D.play("dash_right")
		else:
			$AnimatedSprite2D.play("dash_left")
	elif is_on_floor:
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle")
		else:
			if facing_right:
				$AnimatedSprite2D.play("run_right")
			else:
				$AnimatedSprite2D.play("run_left")
	else:
		if velocity.y < 0:
			if velocity.x == 0:
				$AnimatedSprite2D.play("jump_idle")
			elif facing_right:
				$AnimatedSprite2D.play("jump_right")
			else:
				$AnimatedSprite2D.play("jump_left")
		else:
			if velocity.x == 0:
				$AnimatedSprite2D.play("fall_idle")
			elif facing_right:
				$AnimatedSprite2D.play("fall_right")
			else:
				$AnimatedSprite2D.play("fall_left")
