extends Area2D

func attack():
	$AnimationPlayer.play("Attack")
	var hero = get_parent()
	hero.move(hero.direction * 0.1, 0, false)

func _ready():
	pass
