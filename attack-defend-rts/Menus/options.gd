extends PanelContainer

var current_dir = OS.get_executable_path()
var file_path = null


var options = {
	"window" : 0,
	"borderless" : false,
	"vsync" : 0
}

var screen_types = {
	"windowed" : 0,
	"fullscreen" : 0,
}

func _ready() -> void:
	for i in range(len(current_dir)-1,0,-1):
		if current_dir[i] == "/":
			current_dir[i] = ""
			break
		else:
			current_dir[i] = ""
	file_path = current_dir + "/options.dat"
	fetch_settings()
	$"VBoxContainer/TabContainer/Graphics/VBoxContainer/HSplitContainer/Window Type Button".selected = options["window"]/3

func fetch_settings():
	if FileAccess.file_exists(file_path):
		var file := FileAccess.open(file_path, FileAccess.READ)
		file.get_var()
		file.close()
		set_settings()
	else:
		save_settings()

func save_settings():
	print(file_path)
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_var(options)
	file.close()

func set_settings():
	DisplayServer.window_set_mode(options["window"])
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS,options["borderless"])
	DisplayServer.window_set_vsync_mode(options["vsync"])

func _on_apply_pressed() -> void:
	set_settings()
