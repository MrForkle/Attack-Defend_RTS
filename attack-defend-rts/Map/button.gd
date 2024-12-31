extends Button

func _pressed():
	var team = null
	if $Red.button_pressed == true:
		team = "red"
	elif $Blue.button_pressed == true:
		team = "blue"
	get_parent().get_parent().spawn_unit("Rifleman",team)
