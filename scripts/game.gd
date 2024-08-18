extends Node2D

@onready var seesaw = $Seesaw
@onready var offscreen_seesaw = $OffscreenSeesaw
@onready var player = $Player
@onready var score_label = $CanvasLayer/ScoreLabel

const MAX_ROTATION_SPEED = 75

@export var seesaw_length := 15.0:
	set(value):
		if value < 0.5:
			value = 0.5
		elif value > 15:
			value = 15.0
		else:
			seesaw_length = value
		set_sewsaw_lengths()

@export var decay_speed = 0.1

@export var rotation_speed := 0.0
			
@export var score := 0:
	set(value):
		score_label.text = str(score)
		score = value
		
var score_delta_tracker := 0.0

var ground_pound_timer := 0.0

func _process(delta):
	seesaw_length -= decay_speed * delta
	seesaw.rotation_degrees += rotation_speed * delta
	
	if ground_pound_timer > 0:
		ground_pound_timer -= delta
	else:
		if player.is_on_floor():
			var player_position : float = (player.position.x - 3000) / 48
			var player_position_fraction := player_position / seesaw_length
			rotation_speed = lerp(rotation_speed, (MAX_ROTATION_SPEED**2) * player_position_fraction * delta, 0.1)
		else:
			rotation_speed = lerp(rotation_speed, (0 * delta), 0.01)
		
	score_delta_tracker += delta * 10
	if score_delta_tracker > 1:
		score += floor(score_delta_tracker)
		score_delta_tracker -= floor(score_delta_tracker)

func _ground_pound():
	var player_position : float = (player.position.x - 3000) / 48
	var player_position_fraction := player_position / seesaw_length
	rotation_speed = (sign(player_position_fraction) * MAX_ROTATION_SPEED) + (player_position_fraction * MAX_ROTATION_SPEED * 8)
	ground_pound_timer = 0.5

func set_sewsaw_lengths():
	seesaw.length = seesaw_length
	offscreen_seesaw.length = seesaw_length
