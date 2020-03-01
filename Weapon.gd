extends Node2D
var Mouse_Position
export (PackedScene) var Bullet
export (PackedScene) var FireExplosionParticle
var isFire = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Mouse_Position = get_local_mouse_position()
	rotation += Mouse_Position.angle()

func fire(world):
	if !isFire :
		isFire = true
		$TimerFire.start()
		var bullet = Bullet.instance()
		var explosion = FireExplosionParticle.instance()
		
		world.add_child(bullet)
		world.add_child(explosion)
		
		bullet.global_position = $FirePoint.global_position
		explosion.global_position = $FirePoint.global_position
		
		explosion.emitting = true
		
		bullet.linear_velocity = Vector2(300,0)
		bullet.linear_velocity = bullet.linear_velocity.rotated(rotation)
		
		bullet.get_node("BulletSprite").rotation = rotation
		explosion.rotation = rotation
		
		explosion.emitting = true

func _on_TimerFire_timeout():
	isFire = false
