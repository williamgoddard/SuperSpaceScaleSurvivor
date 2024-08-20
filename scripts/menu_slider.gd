extends Node2D

const SLIDER_NOTCH = preload("res://assets/sprites/Slider Notch.png")
const SLIDER_NOTCH_DESELECTED = preload("res://assets/sprites/Slider Notch Deselected.png")

@onready var main_menu_button = $MainMenuButton
@onready var slider_bar = $SliderBar
@onready var slider_notch = $SliderScale/SliderNotch

@export var label_text := "OPTION"
@export var text_colour := "FF5DD1"

@export var slider_position := 10:
	set(value):
		if value < 0:
			slider_position = 0
		elif value > 10:
			slider_position = 10
		else:
			slider_position = value
		slider_notch.position.x = (slider_position * 4) - 20

func _ready():
	main_menu_button.label_text = label_text
	main_menu_button.text_colour = text_colour

func select():
	main_menu_button.select()
	slider_bar.modulate = text_colour
	slider_notch.texture = SLIDER_NOTCH
	
func deselect():
	main_menu_button.deselect()
	slider_bar.modulate = "FFFFFF"
	slider_notch.texture = SLIDER_NOTCH_DESELECTED

func move_left():
	slider_position -= 1
	
func move_right():
	slider_position += 1

func set_slider_position(new_position: int):
	slider_position = new_position
