extends Node2D

var Bullet = preload("res://Bullet.tscn")

var player

func _ready():
	player = get_tree().get_root().get_node("Hack/Hero")

func fire_gun(target):
	print_debug(global_position.direction_to(target.global_position))
	for i in range(1):
		var bullet = Bullet.instance()
		bullet.apply_central_impulse(
			Vector2(1000 * rand_range(0.8, 1), rand_range(0.8, 1) * 1000) *
			global_position.direction_to(target.global_position)
		)
		bullet.get_node("Sprite").look_at(target.global_position)
		bullet.global_position = $Sprite.global_position + Vector2(20, 0)
		get_tree().get_root().get_node("Hack").add_child(bullet)

func _process(delta):
	var collider = $RayCast2D.get_collider()
	if !collider:
		$Line2D.default_color = Color.yellow
		$Light2D.color = Color.yellow
		rotate(delta)
	elif collider.get_class() == "Hero":
		$Line2D.default_color = Color.red
		$Light2D.color = Color.red
		look_at(player.global_position)
		if randf() < 0.25:
			fire_gun(player)
