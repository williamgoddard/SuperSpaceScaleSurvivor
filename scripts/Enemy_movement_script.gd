extends CharacterBody2D

@export var speed : float = 40.0
@export var target_node : Node2D
@export var kill_node : Area2D
@export var game : Game
@export var flipped := false
var died = false

signal enemy_died

func _ready():
	pass

func _physics_process(delta: float):
	if target_node:
		var direction = (target_node.position - position).normalized()
		look_at(target_node.position)
		velocity = direction * speed
		#print(str(velocity) + "" + str(target_node.position)+""+str(get_parent().position))
		if not died:
			move_and_slide()
			$AnimatedSprite2D.play("move")
		
func die():
	#speed = 0
	emit_signal("enemy_died")
	died = true
	#process_mode = Node.PROCESS_MODE_DISABLED
	$AnimatedSprite2D.play("die")

func _on_area_2d_body_entered(body):
	if body is Whacker and abs(game.rotation_speed) > 30:
		if (flipped and game.rotation_speed > 0) or (not flipped and game.rotation_speed < 0):
			die()
	print(body)
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "die":
		queue_free() 
	pass # Replace with function body.


func _on_area_2d_area_entered(kill_node):
	pass # Replace with function body.
