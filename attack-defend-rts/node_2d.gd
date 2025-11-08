extends Label

var start_string = "Connecting "
var states = [".",". .",". . ."]
var index = 0

func _ready() -> void:
	text = start_string + states[index]
	index += 1

func _on_timer_timeout() -> void:
	text = start_string + states[index]
	index += 1
	if index >= 3:
		index = 0
