extends CanvasLayer

signal end_game()
signal retry_game()

@onready var retry_button = $RetryButton
@onready var main_menu_button = $MainMenuButton
@onready var score_label = $ScoreLabel

@export var score := 0

const MAX_OPTION := 1

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
	score_label.text = str(score)

func set_selection():
	match selected_option:
		0:
			retry_button.select()
			main_menu_button.deselect()
		1:
			retry_button.deselect()
			main_menu_button.select()
		_:
			retry_button.deselect()
			main_menu_button.deselect()

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
				retry_game.emit()
			1:
				end_game.emit()
