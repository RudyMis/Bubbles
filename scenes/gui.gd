extends MarginContainer

export (NodePath) var path_create_button

onready var create_button = get_node(path_create_button)

func _ready():
	pass

func _on_toggle(button_pressed):
	if create_button == null: return
	create_button.disable(button_pressed)
