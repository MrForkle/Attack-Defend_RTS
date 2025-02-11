extends PanelContainer

var options = {
	"window" : null,
	"borderless" : null,
	"vsync" : null
}

var screen_types = {
	"windowed" : 0,
	"fullscreen" : 0,
}

func _ready() -> void:
	fetch_settings()
	$"VBoxContainer/TabContainer/Graphics/VBoxContainer/HSplitContainer/Window Type Button".selected = options["window"]/3
	

func fetch_settings():
	options["window"] = ProjectSettings.get_setting("display/window/size/mode")
	options["vsync"] = ProjectSettings.get_setting("display/window/vsync/vsync_mode")
	options["borderless"] = ProjectSettings.get_setting("display/window/size/borderless")

func set_settings():
	ProjectSettings.set_setting("display/window/size/mode",options["window"])
	ProjectSettings.set_setting("display/window/vsync/vsync_mode",options["vsync"])
	ProjectSettings.set_setting("display/window/size/borderless",options["borderless"])
	ProjectSettings.save()

func _on_apply_pressed() -> void:
	set_settings()
