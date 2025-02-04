extends Button
var field_base = preload("res://field_base.tscn")
var cost = 500

func _on_pressed() -> void:
	if get_tree().get_root().get_node("Map/CanvasLayer/RichTextLabel").check_money(cost) != true:
		return
	get_tree().get_root().get_node("Map/CanvasLayer/RichTextLabel").update_money(-cost)
	var field_base_instantiated = field_base.instantiate()
	field_base_instantiated.begin_placing()
	get_tree().get_root().get_node("Map").add_child(field_base_instantiated)
