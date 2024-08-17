extends Node2D

@onready var seesaw = $Seesaw
@onready var offscreen_seesaw = $OffscreenSeesaw
@onready var player = $Player

const MAX_ROTATION_SPEED = 60

@export var seesaw_length := 10.0:
	set(value):
		if value < 0.5:
			value = 0.5
		elif value > 12:
			value = 12
		else:
			seesaw_length = value
		set_sewsaw_lengths()

@export var decay_speed = 0.2

@export var rotation_speed := 0.0:
	set(value):
		if value > MAX_ROTATION_SPEED:
			rotation_speed = MAX_ROTATION_SPEED
		elif value < -MAX_ROTATION_SPEED:
			rotation_speed = -MAX_ROTATION_SPEED
		else:
			rotation_speed = value

func _process(delta):
	seesaw_length -= decay_speed * delta
	seesaw.rotation_degrees += rotation_speed * delta
	
	if player.is_on_floor():
		var player_position : float = (player.position.x - 3000) / 48
		var player_position_fraction := player_position / seesaw_length
		#rotation_speed += (MAX_ROTATION_SPEED * player_position_fraction) * delta
		rotation_speed = lerp(rotation_speed, (MAX_ROTATION_SPEED**2) * player_position_fraction * delta, 1)
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_sewsaw_lengths():
	seesaw.length = seesaw_length
	offscreen_seesaw.length = seesaw_length
