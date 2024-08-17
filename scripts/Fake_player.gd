extends Node2D

@export var actual_player: NodePath

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
