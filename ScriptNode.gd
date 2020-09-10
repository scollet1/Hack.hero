extends GraphNode

var _text
var script_window

func update_window():
	if script_window.current_owner != self:
		script_window.set_owner(self)
	elif script_window.open:
		script_window.close()
	else:
		script_window.open()

func exec():
	script_window.set_owner(self)
	return script_window.exec()

func _process(delta):
	if Input.is_key_pressed(KEY_DELETE) and selected == true:
		queue_free()

func _ready():
	_text = ""
	script_window = find_parent("MainCamera").get_node("CodeWindow")
