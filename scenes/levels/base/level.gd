extends CanvasLayer

export (NodePath) var path_create_bubbles

onready var create_bubbles = get_node(path_create_bubbles)

func _ready():
	pass # Replace with function body.


func _on_no_bubbles():
	if create_bubbles == null: return
	create_bubbles.disable(true)
