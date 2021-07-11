extends Area2D


export var speed = 40 # Prędkość animacji oraz baniek, które wlatują.

func _ready():
	gravity = float(speed * 10)
	gravity_vec = Vector2(0, -1).rotated(rotation_degrees)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
