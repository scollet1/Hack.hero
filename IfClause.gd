extends GraphNode

const UP = -1
const DOWN = 1
const LEFT = -1
const RIGHT = 1
const STRAIGHT = 0

func add_statements(num):
	var first = true
	for i in range(num):
		var s = LineEdit.new()
		add_child(s)
		set_slot(i, first, 1, Color.aqua, true, 1, Color.coral)
		first = false

func exec():
	for i in get_children():
		var statement = i.text
		var expression = Expression.new()
		var error = expression.parse(statement, ["Hack", "UP", "DOWN", "LEFT", "RIGHT"])
		if error != OK:
			var error_text = expression.get_error_text()
			return
		var result = expression.execute([find_parent("Hack"), UP, DOWN, LEFT, RIGHT], null, true)
#		print_debug(result)
		if !expression.has_execute_failed():
			if result == true:
				return i.get_index()
		else:
			return -1
	return -1

func _process(delta):
	if Input.is_key_pressed(KEY_DELETE) and selected == true:
		queue_free()

func _ready():
	pass
