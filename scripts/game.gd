class_name Game extends Node2D

signal return_to_menu()
signal retry_game()
signal game_over_signal(state: bool)
signal seesaw_length_signal(length: float)
signal enemy_died_signal()
signal jump_signal(jumps: int)
signal dash_signal()
signal dash_replenish_signal()
signal star_collected_signal()
signal ground_pound_start_signal()
signal ground_pound_land_signal(distance: float)
signal place_whacker_signal()
signal whacker_destroy_signal()
signal seesaw_destroy_signal()
signal seesaw_damage_signal()
signal menu_option_hover_signal()
signal menu_option_select_signal()

const WHACKER = preload("res://scene/whacker.tscn")
const GAME_OVER_MENU = preload("res://scene/game_over_menu.tscn")

@onready var seesaw = $Seesaw
@onready var offscreen_seesaw = $OffscreenSeesaw
@onready var player = $Player
@onready var score_label = $CanvasLayer/ScoreLabel
@onready var fake_player = $Seesaw/Fake_player
@onready var canvas_layer = $CanvasLayer
@onready var gpu_particles_2d = $Seesaw/GPUParticles2D
@onready var enemies_spawn = $Enemies_spawn

var whackers : Array[Whacker] = []

var time_until_next_enemy := 5.0
var game_time := 0.0

const MAX_ROTATION_SPEED = 60

@export var seesaw_length := 15.0:
	set(value):
		if value < 0.5:
			seesaw_length = 0.5
		elif value > 15.0:
			seesaw_length = 15.0
		else:
			seesaw_length = value
		seesaw_length_signal.emit(seesaw_length)
		set_sewsaw_lengths()
		var whackers_to_remove : Array[Whacker] = []
		for whacker in whackers:
			if abs(whacker.position.x) > (seesaw_length * 48) + 80:
				whackers_to_remove.append(whacker)
		for whacker in whackers_to_remove:
			whackers.erase(whacker)
			whacker.destroy()

@export var decay_speed = 0.1

@export var rotation_speed := 0.0
			
@export var score := 0:
	set(value):
		score_label.text = str(score)
		score = value
		
@export var game_over := false:
	set(value):
		game_over_signal.emit(value)
		game_over = value
		
var score_delta_tracker := 0.0

var ground_pound_timer := 0.0

func _ready():
	enemies_spawn.spawn_enemy()
	enemies_spawn.spawn_enemy()
	enemies_spawn.spawn_enemy()

func _process(delta):
	
	game_time += delta
	time_until_next_enemy -= delta
	
	seesaw_length -= decay_speed * delta
	seesaw.rotation_degrees += rotation_speed * delta
	
	if ground_pound_timer > 0:
		ground_pound_timer -= delta
	else:
		if player.is_on_floor():
			var player_position : float = (player.position.x - 3000) / 48
			var player_position_fraction := player_position / seesaw_length
			rotation_speed = lerp(rotation_speed, (MAX_ROTATION_SPEED**2) * player_position_fraction * delta, 0.1)
		elif abs(rotation_speed) <= MAX_ROTATION_SPEED:
			rotation_speed = lerp(rotation_speed, 0.0, 0.01)
		else:
			rotation_speed = lerp(rotation_speed, 0.0, 0.1)
			
	if player.position.y >= 1000 and not game_over:
		end_game()
	
	if not game_over:
		score_delta_tracker += delta * 10
		if score_delta_tracker > 1:
			score += floor(score_delta_tracker)
			score_delta_tracker -= floor(score_delta_tracker)
	
	if not game_over:
		if Input.is_action_just_pressed("ground_pound") and player.is_on_floor():
			var whacker = WHACKER.instantiate()
			var whacker_position : int = player.position.x - 3000
			if abs(whacker_position) < 104:
				whacker_position = sign(whacker_position) * 104
			if abs(whacker_position) < 104:
				whacker_position = 104
			whacker.position.x = whacker_position
			whacker.z_index = -10
			var whackers_to_remove : Array[Whacker] = []
			for other_whacker in whackers:
				if abs(whacker.position.x - other_whacker.position.x) < 104:
					whackers_to_remove.append(other_whacker)
			for other_whacker in whackers_to_remove:
				whackers.erase(other_whacker)
				other_whacker.destroy()
			if whackers.size() >= 3:
				var old_whacker = whackers.pop_front()
				whackers.erase(old_whacker)
				old_whacker.destroy()
			whackers.push_back(whacker)
			seesaw.add_child(whacker)
			whacker.whacker_destroy_signal.connect(_on_whacker_destroy_signal)
			place_whacker_signal.emit()
			
	var whackers_to_remove : Array[Whacker] = []
	for whacker in whackers:
		if whacker.hit_enemy_timer > whacker.HIT_ENEMY_TIMEOUT:
			whackers_to_remove.append(whacker)
	for whacker in whackers_to_remove:
		whackers.erase(whacker)
		whacker.destroy()
	
	if not game_over:
		if time_until_next_enemy <= 0:
			for i in range(randi_range(1,3)):
				enemies_spawn.spawn_enemy()
			var game_time_minutes = game_time / 60.0
			if game_time_minutes <= 5.0:
				time_until_next_enemy = (6 - (5 * (log(game_time_minutes+1) / log(10)))) + randf_range(-0.5, 0.5)
			else:
				time_until_next_enemy = randf_range(0.1, 0.5)

func _ground_pound_start():
	ground_pound_start_signal.emit()

func _ground_pound():
	var player_position : float = (player.position.x - 3000) / 48
	var player_position_fraction := player_position / seesaw_length
	if abs(player_position_fraction) > 1:
		player_position_fraction = sign(player_position_fraction)
	rotation_speed = (sign(player_position_fraction) * MAX_ROTATION_SPEED / 2) + (player_position_fraction * MAX_ROTATION_SPEED * 12)
	ground_pound_timer = 0.5
	ground_pound_land_signal.emit(abs(player_position_fraction) * 100)
	
func _enemy_died():
	score += abs(floor(rotation_speed))
	enemy_died_signal.emit()
	
func _star_collected():
	seesaw_length += 2.0
	star_collected_signal.emit()
	score += 5000

func set_sewsaw_lengths():
	seesaw.length = seesaw_length
	offscreen_seesaw.length = seesaw_length
	
func end_game():
	game_over = true
	canvas_layer.hide()
	var game_over_menu := GAME_OVER_MENU.instantiate()
	game_over_menu.score = score
	game_over_menu.end_game.connect(_return_to_menu)
	game_over_menu.retry_game.connect(_retry_game)
	add_child(game_over_menu)

func _on_increase_length_pressed():
	seesaw_length += 1

func _on_decrease_length_pressed():
	seesaw_length -= 1

func _return_to_menu():
	return_to_menu.emit()

func _retry_game():
	retry_game.emit()

func _on_player_jump_signal(jumps: int):
	jump_signal.emit(jumps)

func _on_player_dash_signal():
	dash_signal.emit()

func _on_player_dash_replenish_signal():
	dash_replenish_signal.emit()
	
func _on_whacker_destroy_signal():
	whacker_destroy_signal.emit()
	
func _on_menu_option_hover_signal():
	menu_option_hover_signal.emit()
	
func _on_menu_option_select_signal():
	menu_option_select_signal.emit()

func _on_area_2d_body_entered(body):
	if body is BasicEnemy:
		body.die()
		seesaw_damaged(1.0)
	pass # Replace with function body.

func seesaw_damaged(damage: float):
	check_if_destroyed()
	seesaw_length -= damage
	
var destroyed := false

func check_if_destroyed():
	print(seesaw_length)
	if seesaw_length <= 0.5 and not destroyed:
		seesaw.destroy()
		offscreen_seesaw.destroy()
		gpu_particles_2d.emitting = true
		await get_tree(). create_timer(2.0). timeout
		gpu_particles_2d.emitting = false
		destroyed = true
		seesaw_destroy_signal.emit()
	elif not destroyed:
		seesaw_damage_signal.emit()
