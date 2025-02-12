extends CheckButton

func _on_button_up() -> void:
	get_tree().get_root().get_node("Main/Options").options["borderless"] = true

func _on_button_down() -> void:
	get_tree().get_root().get_node("Main/Options").options["borderless"] = false
