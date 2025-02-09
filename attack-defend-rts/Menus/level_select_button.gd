extends Button

func _on_pressed() -> void:
	get_parent().hide()
	get_parent().get_parent().get_node("Level Select").show()
