extends Sprite

func enable(f):
	frame = f
	visible = true
	$Timer.start(2)

func on_timeout():
	visible = false

func _ready():
	visible = false
	$Timer.connect("timeout", self, "on_timeout")
