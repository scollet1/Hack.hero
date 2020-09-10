extends Node2D

var Bullet = preload("res://Bullet.tscn")

func attack():
	for i in range(8):
		var bullet = Bullet.instance()
		bullet.apply_central_impulse(Vector2(1000 * randf(), rand_range(-1, 1) * 100) * get_parent().direction)
		bullet.global_position = global_position
		get_tree().get_root().get_node("Hack").add_child(bullet)
		bullet.global_position.x += 5
	$AnimationPlayer.play("Attack")
	var hero = get_parent()
	hero.move(-hero.direction, 0, false)

func _ready():
	pass
