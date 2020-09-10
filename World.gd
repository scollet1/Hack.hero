extends Node2D

onready var hero = $Hero
onready var key = $Key

func to_the_right_of(a, b):
	return a.global_position.x > b.global_position.x

func to_the_left_of(a, b):
	return a.global_position.x < b.global_position.x

func below(a, b):
	return a.global_position.y > b.global_position.y

func above(a, b):
	return a.global_position.y < b.global_position.y

func _ready():
	pass
