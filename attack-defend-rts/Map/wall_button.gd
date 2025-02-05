extends Button
var wall = preload("res://Player Buildings/Walls/wall.tscn")
var cost = 300

func _on_pressed() -> void:
	if get_tree().get_root().get_node("Map/CanvasLayer/RichTextLabel").check_money(cost) != true:
		return
	get_tree().get_root().get_node("Map/CanvasLayer/RichTextLabel").update_money(-cost)
	var wall_instantiated = wall.instantiate()
	wall_instantiated.begin_placing()
	if get_tree().get_root().get_node("Map").player_team == "red":
		var material = get_tree().get_root().get_node("Map").red_material
	else:
		var material = get_tree().get_root().get_node("Map").blue_material
	wall_instantiated.set_values(get_tree().get_root().get_node("Map").player_team,material)
	get_tree().get_root().get_node("Map").add_child(wall_instantiated)
