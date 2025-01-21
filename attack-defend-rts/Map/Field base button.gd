extends Button
var field_base = preload("res://field_base.tscn")


func _on_pressed() -> void:
	var field_base_instantiated = field_base.instantiate()
	field_base_instantiated.begin_placing()
	get_tree().get_root().get_node("Map").add_child(field_base_instantiated)
