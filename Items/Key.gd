extends Area2D

func on_body_entered(body):
	if body.get_class() == "Hero":
		get_tree().reload_current_scene()

func _ready():
	connect("body_entered", self, "on_body_entered")
