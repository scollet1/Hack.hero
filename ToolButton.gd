extends CheckButton

func on():
	get_parent().get_node("AnimationPlayer").play_backwards("Close")

func off():
	get_parent().get_node("AnimationPlayer").play("Close")

func on_press():
	if pressed: on()
	else: off()

func _ready():
	connect("pressed", self, "on_press")
