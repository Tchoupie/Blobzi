extends KinematicBody2D
export (PackedScene) var Weapon
export (int) var speed = 200

var velocity = Vector2()
var screen_size
var mouse_position


func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	mouse_position = get_viewport().get_mouse_position()
	if(mouse_position.x < position.x):
		$Weapon.position.x = -50
		$Weapon/Sprite.set_flip_v(true)
	else:
		$Weapon.position.x = 50
		$Weapon/Sprite.set_flip_v(false)

func _physics_process(delta):
	get_input()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _input(event):
	if event is InputEventMouseButton:
		var world  = get_owner()
		$Weapon.fire(world)
