tool
extends Area2D

export (float) var speed := 40 # Prędkość animacji oraz baniek, które wlatują.
export (NodePath) var path_end = null
onready var end : Node2D = get_node(path_end)

func _ready():
	gravity = float(speed * 10)
	gravity_vec = Vector2(0, -1).rotated(rotation_degrees)

func _process(delta : float):
	if end == null:
		if path_end == null: return
		end = get_node(path_end)
	look_at(end.position)
	var dist = position.distance_to(end.position)
	$particles.visibility_rect.size.x = dist
	$particles.lifetime = dist / 20
	$boost_col.shape.extents.x = dist / 2 
	$boost_col.position.x = dist / 2
