extends MarginContainer

export (NodePath) var create_button

func _ready():
	create_button = get_node(create_button)


func _on_toggle(button_pressed):
	create_button.disabled = button_pressed
	create_button.mouse_filter = 2 if button_pressed else 0
