extends RigidBody2D

var size
export var hack_type : String

func hack_type():
	pass

func make_room(_pos, _size):
	position = _pos
	size = _size
	var rect = RectangleShape2D.new()
	rect.custom_solver_bias = 0.5
	rect.extents = size
	$CollisionShape2D.shape = rect

func _ready():
	pass # Replace with function body.
