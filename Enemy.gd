extends KinematicBody2D

export (int) var life = 100
export (float) var speed_bwark = 1
export (PackedScene) var Bwark


var isFire = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if $RayCast2D.is_colliding():
		var collision_body = $RayCast2D.get_collider()
		if collision_body.is_in_group("Good_Blob"):
			fire(get_node("/root/World"))
	else:
		$RayCast2D.rotation += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if life<=0 :
		queue_free()

func hit(damage):
	life -= damage
	print_debug(life)


func _on_Area_body_entered(body):
	if (body.is_in_group("Damage")):
		hit(body.damage)
	if(body.is_in_group("Bullet")):
		body.queue_free()

func fire(world):
	if !isFire :
		isFire = true
		$TimerFire.start()
		var bwark = Bwark.instance()
		world.add_child(bwark)
		
		bwark.global_position = $FirePoint.global_position
		
		var direction = $RayCast2D.cast_to
		
		bwark.linear_velocity = direction * speed_bwark
		bwark.linear_velocity = bwark.linear_velocity.rotated($RayCast2D.rotation)
		
		bwark.get_node("Sprite").rotation = $RayCast2D.rotation + 1.5

func _on_TimerFire_timeout():
	isFire = false
