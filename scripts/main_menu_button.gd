extends Node2D

#const deselect_sprite = preload("res://assets/sprites/693xr583.bmp")
#const select_sprite = preload("res://assets/sprites/jh6zlhbm.bmp")

@onready var label = $Label
@onready var sprite = $Sprite2D

@export var label_text := "OPTION"
@export var text_colour := "FF5DD1"

func _ready():
	label.text = label_text
	
func _process(_delta):
	label.text = label_text

func select():
	sprite.modulate = text_colour
	label.add_theme_color_override("font_color", text_colour)
	
func deselect():
	sprite.modulate = "FFFFFF"
	label.add_theme_color_override("font_color", "FFFFFF")
