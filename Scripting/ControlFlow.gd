extends GraphEdit

onready var queue = []
onready var nodes = {}
onready var IfClause = preload("res://Scripting/IfClause.tscn")

func new_if_clause(num_out):
	var ifclause = IfClause.instance()
	ifclause.add_statements(num_out)
	add_child(ifclause)

func exec():
	var connections = get_connection_list()
	print_debug(connections)
	if connections:
		nodes = {}
		var key = 'from'
		var starting_node
		for c in connections:
			print_debug(c)
			if not c[key] in nodes:
				nodes[c[key]] = []
			if nodes[c[key]] != null:
				nodes[c[key]].append(c)

		queue = ['StartNode']
		return true
	return false

func halt_execution():
	queue = []
	return queue == []

func _process(delta):
	if !queue.empty():
		print_debug(queue)
		var node_name = queue.pop_front()
		var node = get_node_or_null(node_name)
		if node:
			var next_node = node.exec() # please no loops
			if node_name in nodes and next_node != -1 and next_node and next_node < len(nodes[node_name]):
				queue.push_back(nodes[node_name][next_node]['to'])

func on_connection_request(from, fslot, to, tslot):
	connect_node(from, fslot, to, tslot)

func on_disconnect_request(from, fslot, to, tslot):
	disconnect_node(from, fslot, to, tslot)

func _ready():
	connect("connection_request", self, "on_connection_request")
	connect("disconnection_request", self, "on_disconnect_request")
