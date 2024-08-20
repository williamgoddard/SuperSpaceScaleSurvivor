class_name Whacker extends StaticBody2D

signal whacker_destroy_signal()

@onready var animated_sprite_2d := $AnimatedSprite2D

const HIT_ENEMY_TIMEOUT = 2.0

var hit_enemy := false
var hit_enemy_timer := 0.0

func destroy():
	whacker_destroy_signal.emit()
	animated_sprite_2d.play("destroy")
	collision_layer = 0

func _process(delta):
	if hit_enemy:
		hit_enemy_timer	+= delta

func _on_animation_finished():
	if animated_sprite_2d.animation == "destroy":
		queue_free()
