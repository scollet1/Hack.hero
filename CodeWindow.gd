extends Panel

var editor
var current_owner
onready var open = false

const UP = -1
const DOWN = 1
const LEFT = -1
const RIGHT = 1
const STRAIGHT = 0

func exec():
	var _text = ""
	if current_owner:
		_text = current_owner._text.split('\n')
	for line in _text:
		var expression = Expression.new()
		var error = expression.parse(line, ["Hack", "LEFT", "RIGHT", "UP", "DOWN"])
		var result_label = $VBoxContainer/RichTextLabel
		if error != OK:
			var error_text = expression.get_error_text()
			result_label.text = error_text
			return
		var result = expression.execute([find_parent("Hack"), LEFT, RIGHT, UP, DOWN], null, true)
		if !expression.has_execute_failed():
			var s_res = str(result)
			if s_res.empty():
				s_res = String(result)
			result_label.text = s_res
	return 0

func open():
	open = true
	get_parent().get_node("AnimationPlayer").play_backwards("Close")

func close():
	open = false
	get_parent().get_node("AnimationPlayer").play("Close")

func on_text_change():
	current_owner._text = editor.text

func set_owner(new_owner):
	current_owner = new_owner
	editor.text = current_owner._text

func _ready():
	editor = $VBoxContainer/TextEdit
	editor.connect("text_changed", self, "on_text_change")
