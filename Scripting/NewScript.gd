extends ToolButton

var ScriptNode = preload("res://Scripting/ScriptNode.tscn")

func on_press():
	var node = ScriptNode.instance()
	get_parent().add_child(node)

func _ready():
	connect("button_down", self, "on_press")
