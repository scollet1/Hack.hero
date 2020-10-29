extends RigidBody2D

func on_timeout():
	queue_free()

func _ready():
	$Timer.connect("timeout", self, "on_timeout")
	$Timer.one_shot = false
	$Timer.start(2)
