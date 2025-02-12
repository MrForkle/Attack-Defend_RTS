extends Button

var map = preload("res://Map/map.tscn")

func _on_pressed() -> void:
	var map_instantiated = map.instantiate()
	get_tree().get_root().add_child(map_instantiated)
	get_tree().get_root().get_node("Main").hide()
