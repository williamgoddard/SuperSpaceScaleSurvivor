extends Node2D

signal start_game()
signal options_menu()
signal tutorial_screen()
signal menu_option_hover_signal()
signal menu_option_select_signal()

@onready var play_button = $PlayButton
@onready var options_button = $OptionsButton
@onready var tutorial_button = $TutorialButton
@onready var exit_button = $ExitButton

const MAX_OPTION := 3

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
			tutorial_button.deselect()
			exit_button.deselect()
		1:
			play_button.deselect()
			options_button.select()
			tutorial_button.deselect()
			exit_button.deselect()
		2:
			play_button.deselect()
			options_button.deselect()
			tutorial_button.select()
			exit_button.deselect()
		3:
			play_button.deselect()
			options_button.deselect()
			tutorial_button.deselect()
			exit_button.select()
		_:
			play_button.deselect()
			options_button.deselect()
			tutorial_button.deselect()
			exit_button.deselect()
	menu_option_hover_signal.emit()

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		selected_option += 1
		set_selection()
	if Input.is_action_just_pressed("ui_up"):
		selected_option -= 1
		set_selection()
	if Input.is_action_just_pressed("ui_select"):
		menu_option_select_signal.emit()
		match selected_option:
			0:
				start_game.emit()
			1:
				options_menu.emit()
			2:
				tutorial_screen.emit()
			3:
				get_tree().quit()
