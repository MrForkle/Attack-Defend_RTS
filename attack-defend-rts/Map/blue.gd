extends Button

func _pressed():
	get_parent().get_node("Red").button_pressed = false
