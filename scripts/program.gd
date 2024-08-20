extends Node2D

enum GameState {MENU, INGAME, GAME_OVER}
@onready var enemy_death_event = $InitBank/MainBank/enemyDeathEvent
@onready var play_music = $InitBank/MainBank/playMusic
@onready var play_smash = $InitBank/MainBank/playSmash
@onready var play_jump = $InitBank/MainBank/playJump

const MAIN_MENU = preload("res://scene/main_menu.tscn")
const OPTIONS_MENU = preload("res://scene/options_menu.tscn")
const GAME = preload("res://scene/game.tscn")

var current_scene : Node

var seesaw_length := 0.0:
	set(value):
		seesaw_length = value
		Wwise.set_rtpc_value("seesawLength",seesaw_length,play_music)
	
var game_state := GameState.MENU:
	set(value):
		game_state = value
		
		if (game_state == GameState.MENU):
		
			Wwise.set_state("gamestate","menu")
		elif (game_state == GameState.INGAME):
			Wwise.set_state("gamestate","battle")
		elif (game_state == GameState.GAME_OVER):
			Wwise.set_state("gamestate", "gameover")
			

var music_volume := 100:
	set(value):
		if value < 0:
			music_volume = 0
		elif value > 100:
			music_volume = 100
		else:
			music_volume = value
			
var sound_volume := 100:
	set(value):
		if value < 0:
			sound_volume = 0
		elif value > 100:
			sound_volume = 100
		else:
			sound_volume = value

# Called when the node enters the scene tree for the first time.
func _ready():
	var main_menu = MAIN_MENU.instantiate()
	current_scene = main_menu
	main_menu.start_game.connect(_set_game)
	main_menu.options_menu.connect(_set_options_menu)
	main_menu.menu_option_hover_signal.connect(_menu_option_hover)
	main_menu.menu_option_select_signal.connect(_menu_option_press)
	add_child(main_menu)
	game_state = GameState.MENU
	Wwise.register_game_obj(self, "Program")
	Wwise.post_event("enemyDeath", self)

func _set_main_menu():
	current_scene.queue_free()
	var main_menu = MAIN_MENU.instantiate()
	current_scene = main_menu
	main_menu.start_game.connect(_set_game)
	main_menu.options_menu.connect(_set_options_menu)
	main_menu.menu_option_hover_signal.connect(_menu_option_hover)
	main_menu.menu_option_select_signal.connect(_menu_option_press)
	add_child(main_menu)
	game_state = GameState.MENU
	
func _set_options_menu():
	current_scene.queue_free()
	var options_menu = OPTIONS_MENU.instantiate()
	current_scene = options_menu
	options_menu.return_to_menu.connect(_set_main_menu)
	options_menu.menu_option_hover_signal.connect(_menu_option_hover)
	options_menu.menu_option_select_signal.connect(_menu_option_press)
	options_menu.change_music_volume.connect(_change_music_volume)
	options_menu.change_sound_volume.connect(_change_sound_volume)
	options_menu.set_music_volume(music_volume)
	options_menu.set_sound_volume(sound_volume)
	add_child(options_menu)

func _set_game():
	current_scene.queue_free()
	var game_scene = GAME.instantiate()
	current_scene = game_scene
	game_scene.return_to_menu.connect(_set_main_menu)
	game_scene.retry_game.connect(_set_game)
	game_scene.game_over_signal.connect(_game_over)
	game_scene.seesaw_length_signal.connect(_set_seesaw_length)
	game_scene.enemy_died_signal.connect(_enemy_died)
	game_scene.jump_signal.connect(_jump)
	game_scene.dash_signal.connect(_dash)
	game_scene.dash_replenish_signal.connect(_dash_replenish)
	game_scene.ground_pound_start_signal.connect(_ground_pound_start)
	game_scene.ground_pound_land_signal.connect(_ground_pound_land)
	game_scene.place_whacker_signal.connect(_place_whacker)
	game_scene.whacker_destroy_signal.connect(_whacker_destroy)
	game_scene.star_collected_signal.connect(_powerup_collect)
	game_scene.seesaw_destroy_signal.connect(_seesaw_destroy)
	game_scene.seesaw_damage_signal.connect(_seesaw_damage)
	game_scene.menu_option_hover_signal.connect(_menu_option_hover)
	game_scene.menu_option_select_signal.connect(_menu_option_press)
	add_child(game_scene)
	game_state = GameState.INGAME

func _game_over(value : bool):
	game_state = GameState.GAME_OVER

func _set_seesaw_length(value : float):
	seesaw_length = value

func _enemy_died():
	$InitBank/MainBank/enemyDeathEvent.post_event()
	pass  
	  

func _jump(jumps: int):
	if (jumps == 1 ):
		Wwise.set_switch("jump", "first",play_jump)
	elif (jumps == 2 ):
		Wwise.set_switch("jump", "second",play_jump)
	elif (jumps == 3 ):
		Wwise.set_switch("jump", "third",play_jump)
	$InitBank/MainBank/playJump.post_event()
	pass

func _dash():
	$InitBank/MainBank/playDash.post_event()
	pass

func _dash_replenish():
	pass

func _ground_pound_start():
	pass

func _ground_pound_land(distance: float):
	Wwise.set_rtpc_value("positionCrashSeesaw",distance,play_smash)
	$InitBank/MainBank/playSmash.post_event()
	pass

func _place_whacker():
	pass
	
func _whacker_destroy():
	pass

	
func _powerup_collect():
	$InitBank/MainBank/playStar.post_event()
	pass

func _seesaw_destroy():
	pass
	
func _seesaw_damage():
	pass

func _menu_option_hover():
	pass

func _menu_option_press():
	$InitBank/MainBank/playTick.post_event()
	pass

func _change_music_volume(volume: int):
	music_volume = volume
	pass

func _change_sound_volume(volume: int):
	sound_volume = volume
	pass

