tool
extends Area2D

export (float) var speed := 40 # Prędkość animacji oraz baniek, które wlatują.
export (NodePath) var path_end = null
onready var end : Node2D = get_node(path_end)

func _ready():
	gravity = float(speed * 10)
	gravity_vec = Vector2(-1, 0).rotated(rotation)
	
	if path_end == null: return
	end = get_node(path_end)
	if end == null: return
	
	look_at(end.global_position)
	var dist = position.distance_to(end.position)
	$particles.visibility_rect.size.x = dist
	$particles.lifetime = dist
	$particles.speed_scale = speed
	$boost_col.shape.extents.x = dist / 2 
	$boost_col.position.x = dist / 2
