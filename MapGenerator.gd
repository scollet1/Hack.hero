extends Node2D

var Room = preload("res://Room.tscn")
onready var Map = get_parent().get_node("TileMap")

var tile_size = 32
var num_rooms = 50
var min_size = 4
var max_size = 10
var vspread = 800
var cull = 0.75

var path

var architecture = {
	'CPU': 1,
	'GPU': 1,
	'RAM': 2,
	'MOBO': 1,
	'HDD': 2,
	'SDD': 1,
	'DD': 1,
	'USB': 2,
	'ETH':1,
	'WLAN':1
}

var room_cache = {}

func configure_type(room):
	var r = architecture.keys()[randi() % len(architecture)]
	if room_cache.has(r):
		if room_cache[r] < architecture[r]:
			room_cache[r] += 1
		else:
			r = 'NONE'
	else:
		room_cache[r] = 1
	room.hack_type = r

func calculate_path(points):
	var path = AStar2D.new()
	path.add_point(path.get_available_point_id(), points.pop_front())
	while points:
		var min_dist = INF
		var min_p = null
		var p = null
		for point in path.get_points():
			var pos = path.get_point_position(point)
			for dest in points:
				if pos.distance_to(dest) < min_dist:
					min_dist = pos.distance_to(dest)
					min_p = dest
					p = pos
		var n = path.get_available_point_id()
		path.add_point(n, min_p)
		path.connect_points(path.get_closest_point(p), n)
		points.erase(min_p)
	return path

func cull_rooms():
	var count = 0
	var points = []
	var children = get_children()
	for room in children:
		if randf() < cull and count > len(architecture):
#			room.queue_free()
			pass
		else:
			count += 1
			room.mode = RigidBody2D.MODE_STATIC
			points.append(room.position)
	yield(get_tree(), "idle_frame")
	path = calculate_path(points)
	print(path)
	make_map()

func create_3d_map():
	
	pass

func carve_path(pos1, pos2):
	# Carves a path between two points
	var x_diff = sign(pos2.x - pos1.x)
	var y_diff = sign(pos2.y - pos1.y)
	if x_diff == 0: x_diff = pow(-1.0, randi() % 5)
	if y_diff == 0: y_diff = pow(-1.0, randi() % 5)
	# Carve either x/y or y/x
	var x_y = pos1
	var y_x = pos2
	if (randi() % 2) > 0:
		x_y = pos2
		y_x = pos1
	for x in range(pos1.x, pos2.x, x_diff):
		Map.set_cell(x, x_y.y, 1)
		Map.set_cell(x, x_y.y+y_diff, 1)  # widen the corridor
	for y in range(pos1.y, pos2.y, y_diff):
		Map.set_cell(y_x.x, y, 1)
		Map.set_cell(y_x.x+x_diff, y, 1)  # widen the corridor

func make_map():
	# Creates a TileMap from the generated rooms & path
	# find_start_room()
	# find_end_room()
	Map.clear()

	# Fill TileMap with walls and carve out empty spaces
	var full_rect = Rect2()
	for room in get_children():
		var r = Rect2(
			room.position-room.size,
			room.get_node("CollisionShape2D").shape.extents * 2
		)
		full_rect = full_rect.merge(r)
	var topleft = Map.world_to_map(full_rect.position)
	var bottomright = Map.world_to_map(full_rect.end)
	for x in range(topleft.x, bottomright.x):
		for y in range(topleft.y, bottomright.y):
			Map.set_cell(x, y, 2)

	# Carve rooms and corridors
	print(path)
	var corridors = []  # One corridor per connection
	for room in get_children():
#		configure_type(room)
		var s = (room.size / tile_size).floor()
		var pos = Map.world_to_map(room.position)
		var ul = (room.position / tile_size).floor() - s
		for x in range(2, s.x * 2-1):
			for y in range(2, s.y * 2-1):
				Map.set_cell(ul.x + x, ul.y + y, 1)

		# Carve corridors
		var p = path.get_closest_point(room.position)
		for conn in path.get_point_connections(p):
			if not conn in corridors:
				var start = Map.world_to_map(path.get_point_position(p))
				var end = Map.world_to_map(path.get_point_position(conn))
				carve_path(start, end)
		corridors.append(p)

func make_rooms():
	for i in range(num_rooms):
		var pos = Vector2(0, rand_range(-vspread, vspread))
		var room = Room.instance()
		var w = min_size + randi() % (max_size - min_size)
		var h = min_size + randi() % (max_size - min_size)
		room.make_room(pos, Vector2(w, h) * tile_size)
		add_child(room)
	yield(get_tree().create_timer(1.1), "timeout")
	cull_rooms()

func _ready():
	randomize()
	make_rooms()
