extends RigidBody2D

class_name Bubble
func get_class(): return "Bubble"
func is_class(name): return name == "Bubble" || .is_class(name)

export (PackedScene) var ps_particles

func rescale(s : Vector2):
	$sfx_inflate.play()
	for child in get_children():
		if "scale" in child:
			child.scale = s

func kill():
	var particles = ps_particles.instance()
	particles.position = position
	get_parent().add_child(particles)
	$sfx_pop.play()
	queue_free()

func _ready():
	pass # Replace with function body.

func _on_input_event(viewport, event : InputEvent, shape_idx):
	if event.is_action_pressed("Click"):
		kill()
