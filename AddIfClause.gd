extends ToolButton

var menu
var control
var counter

func on_button_press():
	control.new_if_clause(counter.value)
	menu.visible = false

func _ready():
	menu = find_parent("Popup")
	control = find_parent("ControlFlow")
	counter = get_node("../../SpinBox")
	connect("button_down", self, "on_button_press")
