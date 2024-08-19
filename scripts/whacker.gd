class_name Whacker extends StaticBody2D

const HIT_ENEMY_TIMEOUT = 2.0

var hit_enemy := false
var hit_enemy_timer := 0.0

func destroy():
	queue_free()

func _process(delta):
	
	if hit_enemy:
		hit_enemy_timer	+= delta
