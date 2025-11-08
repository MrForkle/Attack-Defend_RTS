extends Node

func _ready() -> void:
	add_child(load("res://Menus/sign_in_page.tscn").instantiate())

func swap_menu(scene):
	var children = get_children()
	add_child(load(scene).instantiate())
	for i in children:
		i.queue_free()
