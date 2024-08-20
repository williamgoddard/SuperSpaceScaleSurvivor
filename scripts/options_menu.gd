extends Node2D

signal return_to_menu()
signal menu_option_hover_signal()
signal menu_option_select_signal()
signal change_music_volume(volume: int)
signal change_sound_volume(volume: int)

@onready var back_button = $BackButton
@onready var fullscreen_button = $FullscreenButton
@onready var music_slider = $MusicSlider
@onready var sound_slider = $SoundSlider

const MAX_OPTION := 3

var selected_option := 0:
	set(value):
		if value < 0:
			selected_option = MAX_OPTION
		elif value > MAX_OPTION:
			selected_option = 0
		else:
			selected_option = value
@export var music_volume := 100:
	set(value):
		if value < 0:
			music_volume = 0
		elif value > 100:
			music_volume = 100
		else:
			music_volume = value
		change_music_volume.emit(music_volume)
@export var sound_volume := 100:
	set(value):
		if value < 0:
			sound_volume = 0
		elif value > 100:
			sound_volume = 100
		else:
			sound_volume = value
		change_sound_volume.emit(sound_volume)

func _ready():
	music_slider.set_slider_position(music_volume / 10)
	sound_slider.set_slider_position(sound_volume / 10)
	match DisplayServer.window_get_mode():
		DisplayServer.WINDOW_MODE_WINDOWED:
			fullscreen_button.label_text = "WINDOWED"
		DisplayServer.WINDOW_MODE_FULLSCREEN:
			fullscreen_button.label_text = "FULLSCREEN"
		_:
			fullscreen_button.label_text = "FULLSCREEN"
	set_selection()

func set_selection():
	match selected_option:
		0:
			back_button.select()
			fullscreen_button.deselect()
			music_slider.deselect()
			sound_slider.deselect()
		1:
			back_button.deselect()
			fullscreen_button.select()
			music_slider.deselect()
			sound_slider.deselect()
		2:
			back_button.deselect()
			fullscreen_button.deselect()
			music_slider.select()
			sound_slider.deselect()
		3:
			back_button.deselect()
			fullscreen_button.deselect()
			music_slider.deselect()
			sound_slider.select()
		_:
			back_button.deselect()
			fullscreen_button.deselect()
			music_slider.deselect()
			sound_slider.deselect()
	menu_option_hover_signal.emit()

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		selected_option += 1
		set_selection()
	if Input.is_action_just_pressed("ui_up"):
		selected_option -= 1
		set_selection()
	if Input.is_action_just_pressed("ui_left"):
		match selected_option:
			2:
				music_volume -= 10
				menu_option_select_signal.emit()
				music_slider.move_left()
			3:
				sound_volume -= 10
				menu_option_select_signal.emit()
				sound_slider.move_left()
	if Input.is_action_just_pressed("ui_right"):
		match selected_option:
			2:
				music_volume += 10
				menu_option_select_signal.emit()
				music_slider.move_right()
			3:
				sound_volume += 10
				menu_option_select_signal.emit()
				sound_slider.move_right()
	if Input.is_action_just_pressed("ui_select"):
		menu_option_select_signal.emit()
		match selected_option:
			0:
				return_to_menu.emit()
			1:
				match DisplayServer.window_get_mode():
					DisplayServer.WINDOW_MODE_WINDOWED:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
						fullscreen_button.label_text = "FULLSCREEN"
					DisplayServer.WINDOW_MODE_FULLSCREEN:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
						fullscreen_button.label_text = "WINDOWED"
					_:
						DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
						fullscreen_button.label_text = "WINDOWED"

func set_music_volume(volume: int):
	music_volume = volume
	
func set_sound_volume(volume: int):
	sound_volume = volume
