extends TextureButton

func on_press():
	get_parent().update_window()

func _ready():
	connect("button_down", self, "on_press")
