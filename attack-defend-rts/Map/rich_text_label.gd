extends RichTextLabel

var money = 0

func update_money(change):
	money += change
	text = "$" + str(money)

func _ready() -> void:
	update_money(5000)

func _on_timer_timeout() -> void:
	update_money(100)

func check_money(check_value):
	if money >= check_value:
		return true
	else: return false
