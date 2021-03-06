extends AnimatedSprite

signal no_bubbles
signal bubbles

export (PackedScene) var ps_bubble_scanner
export (int) var initial_number_of_bubbles := 10
export (Vector2) var bubble_scale := Vector2(1, 1)
export (NodePath) var path_label
export (NodePath) var path_spawn
export (NodePath) var path_timer
export (NodePath) var path_button

onready var label = get_node(path_label)
onready var spawn = get_node(path_spawn)
onready var timer = get_node(path_timer)
onready var button : TextureButton = get_node(path_button)

onready var number_of_bubbles : int = initial_number_of_bubbles

func remove_bubble():
	number_of_bubbles -= 1
	label.text = String(number_of_bubbles)
	if number_of_bubbles <= 0:
		emit_signal("no_bubbles")

func add_bubble():
	number_of_bubbles += 1
	label.text = String(number_of_bubbles)
	if number_of_bubbles == 1:
		emit_signal("bubbles")

func _ready():
	label.text = String(number_of_bubbles)
	
func _spawn_bubble():
	if number_of_bubbles <= 0: return

	var bubble_scanner = ps_bubble_scanner.instance()
	
	bubble_scanner.set_visible(false)
	bubble_scanner.position = position + spawn.position
	get_parent().add_child(bubble_scanner)
	bubble_scanner.start_growing(timer.wait_time / 2.0, bubble_scale)
	yield(get_tree(), "idle_frame")
	bubble_scanner.set_visible(true)
	if number_of_bubbles > 0 : play("plumm")
	remove_bubble()

func toggle_button(value : bool):
	button.pressed = value

func _on_button_toggled(button_toggle : bool):
	if button_toggle:
		_spawn_bubble()
		timer.start()
	else:
		 timer.stop()

func _on_no_bubbles():
	button.disabled = true
	timer.stop()

func _on_bubbles():
	button.disabled = false
