extends CharacterBody2D

@export var speed : float = 100.0
@export var target_node : Node2D

func _ready():
	pass

func _physics_process(delta: float):
	if target_node:
		var direction = (target_node.position - position).normalized()
		
		velocity = direction * speed
		#print(str(velocity) + "" + str(target_node.position)+""+str(get_parent().position))
		move_and_slide()
		$AnimatedSprite2D.play("move")
func die():
	# Remove the parent of this node
	$AnimatedSprite2D.play("die")
	$AnimatedSprite2D.connect("animation_finished", _on_die_animation_finished)

func _on_die_animation_finished(anim_name: String):
	if anim_name == "die":
		var parent_node = get_parent()
		if parent_node:
			parent_node.queue_free() 
