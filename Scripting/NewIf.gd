extends ToolButton

func on_press():
	$Popup.popup()

func _ready():
	connect("button_down", self, "on_press")
