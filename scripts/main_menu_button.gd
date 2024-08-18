extends Node2D

const deselect_sprite = preload("res://assets/sprites/693xr583.bmp")
const select_sprite = preload("res://assets/sprites/jh6zlhbm.bmp")

@onready var label = $Label
@onready var sprite = $Sprite2D

@export var label_text := "OPTION"

func _ready():
	label.text = label_text

func select():
	sprite.texture = select_sprite
	label.add_theme_color_override("font_color", "FF5DD1")
	
func deselect():
	sprite.texture = deselect_sprite
	label.add_theme_color_override("font_color", "FFFFFF")
