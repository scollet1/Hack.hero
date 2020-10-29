extends KinematicBody2D
class_name Hero
func get_class(): return "Hero"

onready var speed = 10
onready var direction = 1
onready var vel_mux = Mutex.new()
onready var velocity = Vector2.ZERO

onready var modules = {
	'Scanner': $Scanner
}

onready var weapon = $Shotgun
onready var wep_mux = Mutex.new()

func set_position(pos): pass
func set_global_position(pos): pass

func attack():
	weapon.attack()
	$Emotes.enable([9, 29][randi() % 2])

func move_right():
	move(1, 0, true)

func move_left():
	move(-1, 0, true)

func move_up():
	move(0, -1, false)

func move_down():
	move(0, 1, false)

func move(x, y, flip=true):
	velocity = Vector2(sign(x), sign(y))
	if flip:
		if x < 0 and direction > 0:
			direction = -direction
			flip_sprite()
		elif x > 0 and direction < 0:
			direction = -direction
			flip_sprite()

func flip_sprite():
	scale.x = -scale.x
	$MainCamera.scale.x = direction

func _process(delta):
	move_and_collide(velocity * speed)
	velocity -= velocity * 0.1

func _ready():
	pass
