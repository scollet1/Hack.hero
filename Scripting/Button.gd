extends Button

var control
var regions = {
	'start': Rect2(365, 359, 25, 32),
	'end': Rect2(409, 410, 32, 32)
}

enum {
	stopped = 0,
	running = 1
}

onready var state

func exec_script():
	var result = control.exec()
	if !result:
		print_debug("No connections found in node graph")
	return result

func start():
	if state == running:
		stop()
	else:
		if exec_script():
			state = running
			icon.region = regions['end']
			get_parent().set_starting_color(Color.green)

func stop():
	if state == running:
		if control.halt_execution():
			state = stopped
			icon.region = regions['start']
			get_parent().set_starting_color(Color.red)
	else:
		start()

func _ready():
	state = stopped
	connect("pressed", self, "start")
	control = find_parent("ControlFlow")
