extends Node2D

enum GameState {MENU, INGAME, GAME_OVER}
@onready var enemy_death_event = $InitBank/MainBank/enemyDeathEvent
@onready var play_music = $InitBank/MainBank/playMusic


const MAIN_MENU = preload("res://scene/main_menu.tscn")
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
			print_debug("GameState changed to battle!")
			Wwise.set_state("gamestate","battle")
		elif (game_state == GameState.GAME_OVER):
			Wwise.set_state("gamestate", "gameover")
		

# Called when the node enters the scene tree for the first time.
func _ready():
	var main_menu = MAIN_MENU.instantiate()
	current_scene = main_menu
	main_menu.start_game.connect(_set_game)
	add_child(main_menu)
	game_state = GameState.MENU
	Wwise.register_game_obj(self, "Program")
	Wwise.post_event("enemyDeath", self)
	

func _set_main_menu():
	current_scene.queue_free()
	var main_menu = MAIN_MENU.instantiate()
	current_scene = main_menu
	main_menu.start_game.connect(_set_game)
	add_child(main_menu)
	game_state = GameState.MENU
	

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
	add_child(game_scene)
	game_state = GameState.INGAME

func _game_over(value : bool):
	game_state = GameState.GAME_OVER

func _set_seesaw_length(value : float):
	seesaw_length = value

func _enemy_died():
	Wwise.post_event("enemyDeath",enemy_death_event)
	pass

func _jump():
	pass

func _dash():
	pass

func _dash_replenish():
	pass

func _ground_pound_start():
	pass

func _ground_pound_land():
	pass

func _place_whacker():
	pass
	
func _whacker_destroy():
	pass
	
func _powerup_collect():
	pass
	
func _powerup_sparkle():
	pass

func _menu_option_hover():
	pass

func _menu_option_press():
	pass

