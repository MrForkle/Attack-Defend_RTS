extends Node

func _ready() -> void:
	add_child(load("res://Menus/main_menu.tscn").instantiate())
