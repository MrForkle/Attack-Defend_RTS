extends Button

func _pressed():
	get_parent().get_parent().get_parent().spawn_unit("Rifleman",get_tree().get_root().get_node("Map").player_team)
