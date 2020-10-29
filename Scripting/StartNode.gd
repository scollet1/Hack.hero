extends GraphNode

func exec(): return 0

func set_starting_color(scolor):
	set_slot(0, false, 0, Color.white, true, 1, scolor)

func _ready():
	pass
