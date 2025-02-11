extends Button

func _on_pressed() -> void:
	get_tree().get_root().get_node("Main/Options").show()
	get_tree().get_root().get_node("Main/Main menu").hide()
