extends OptionButton

func _on_item_selected(index: int) -> void:
	#fullscreen = 3 in project setting but has an index of 1 so since windowed is 0 it can be multiplied
	#by 3 to get the proper value
	get_tree().get_root().get_node("Main/Options").options["window"] = index*3
