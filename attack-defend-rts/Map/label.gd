extends Label

var money = 10000
var interval = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if interval > 60/10:
		money += 1
		interval = 0
	else: interval += 1
	
	text = "Money: $" + str(money)
