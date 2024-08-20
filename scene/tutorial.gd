extends Node2D

const TUTORIAL_1_IMAGE = preload("res://assets/sprites/Tutorial1.png")
const TUTORIAL_2_IMAGE = preload("res://assets/sprites/Tutorial2.png")
const TUTORIAL_3_IMAGE = preload("res://assets/sprites/Tutorial3.png")
const TUTORIAL_4_IMAGE = preload("res://assets/sprites/Tutorial4.png")

const TUTORIAL_1_VIDEO = preload("res://assets/video/Tutorial1.ogv")
const TUTORIAL_2_VIDEO = preload("res://assets/video/Tutorial2.ogv")
const TUTORIAL_3_VIDEO = preload("res://assets/video/Tutorial3.ogv")

@onready var video_stream_player := $VideoStreamPlayer
@onready var text_image := $TextImage

signal menu_option_select_signal()
signal return_to_menu_signal()

var scene := 0

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		menu_option_select_signal.emit()
		scene += 1
		match scene:
			0:
				video_stream_player.stream = TUTORIAL_1_VIDEO
				text_image.texture = TUTORIAL_1_IMAGE
			1:
				video_stream_player.stream = TUTORIAL_2_VIDEO
				text_image.texture = TUTORIAL_2_IMAGE
			2:
				video_stream_player.stream = TUTORIAL_3_VIDEO
				text_image.texture = TUTORIAL_3_IMAGE
			3:
				text_image.texture = TUTORIAL_4_IMAGE
			4:
				return_to_menu_signal.emit()
			_:
				return_to_menu_signal.emit()
				
		video_stream_player.play()
