extends Node2D

func scan_left():
	return scan(-20, 0)

func scan_right():
	return scan(20, 0)

func scan_up():
	return scan(0, -20)

func scan_down():
	return scan(0, 20)

func scan(x, y):
	var space_state = get_world_2d().direct_space_state
	var gp = global_position
	var result = space_state.intersect_ray(
		gp, Vector2(gp.x, gp.y),
		[self, get_parent()]
	)
	if result:
		return result['collider'].name
	return null

func _ready():
	pass
