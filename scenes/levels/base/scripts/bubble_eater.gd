extends Sprite

signal enough_bubbles

export (NodePath) var path_label
export (int) var required_amount_of_bubbles := 10

onready var remaining : int = required_amount_of_bubbles 
onready var label : Label = get_node(path_label)

func update_number():
	remaining -= 1
	label.text = String(remaining)
	
	if remaining == 0:
		emit_signal("enough_bubbles")

func _ready():
	label.text = String(remaining)

func _on_body_entered(body : Node2D):
	if body.is_in_group("HappyBubble"):
		update_number()
	if body.is_class("Bubble"):
		body.kill()
	else:
		body.queue_free()
