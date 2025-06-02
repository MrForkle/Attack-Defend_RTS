extends Node

func _ready() -> void:
	add_child(load("res://Menus/sign_in_page.tscn").instantiate())

func swap_menu(scene):
	for i in get_children():
		i.queue_free()
	add_child((scene).instantiate())
