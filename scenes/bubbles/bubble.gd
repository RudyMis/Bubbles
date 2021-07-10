extends RigidBody2D

func rescale(s : Vector2):
	for child in get_children():
		if "scale" in child:
			child.scale = s

func _ready():
	pass # Replace with function body.
