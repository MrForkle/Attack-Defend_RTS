extends Button

func _on_pressed() -> void:
	get_tree().get_root().get_node("Main/Join Game").hide()
	get_tree().get_root().get_node("Main/Main menu").show()
