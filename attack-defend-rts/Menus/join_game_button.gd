extends Button

func _on_pressed() -> void:
	get_tree().get_root().get_node("Main/Join Game").show()
	get_tree().get_root().get_node("Main/Main menu").hide()
