extends RigidBody2D

class_name Bubble
func get_class(): return "Bubble"
func is_class(name): return name == "Bubble" || .is_class(name)

func rescale(s : Vector2):
	for child in get_children():
		if "scale" in child:
			child.scale = s

func _ready():
	pass # Replace with function body.


func _on_input_event(viewport, event : InputEvent, shape_idx):
	if event.is_action_pressed("Click"):
		queue_free()
