extends Node2D
export (PackedScene) var Enemy
var enemy
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	enemy = Enemy.instance()
	add_child(enemy)
	enemy.position = Vector2(500,250)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
