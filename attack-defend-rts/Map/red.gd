extends Button

func _pressed():
	get_parent().get_node("Blue").button_pressed = false
