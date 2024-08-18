extends Node2D

const GAME = preload("res://scene/game.tscn")

@onready var play_button = $PlayButton
@onready var options_button = $OptionsButton
@onready var exit_button = $ExitButton

const MAX_OPTION := 2

var selected_option := 0:
	set(value):
		if value < 0:
			selected_option = MAX_OPTION
		elif value > MAX_OPTION:
			selected_option = 0
		else:
			selected_option = value

# Called when the node enters the scene tree for the first time.
func _ready():
	set_selection()

func set_selection():
	match selected_option:
		0:
			play_button.select()
			options_button.deselect()
			exit_button.deselect()
		1:
			play_button.deselect()
			options_button.select()
			exit_button.deselect()
		2:
			play_button.deselect()
			options_button.deselect()
			exit_button.select()
		_:
			play_button.deselect()
			options_button.deselect()
			exit_button.deselect()

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		selected_option += 1
		set_selection()
	if Input.is_action_just_pressed("ui_up"):
		selected_option -= 1
		set_selection()
	if Input.is_action_just_pressed("ui_select"):
		match selected_option:
			0:
				get_tree().change_scene_to_packed(GAME)
