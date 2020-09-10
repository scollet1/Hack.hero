extends ToolButton

var menu

func on_button_press():
	menu.visible = false

func _ready():
	menu = find_parent("Popup")
	connect("button_down", self, "on_button_press")
