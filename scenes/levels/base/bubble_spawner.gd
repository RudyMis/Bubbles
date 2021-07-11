extends Sprite

signal no_bubbles

export (PackedScene) var ps_bubble_scanner
export (int) var initial_number_of_bubbles := 10
export (Vector2) var bubble_scale := Vector2(1, 1)
export (NodePath) var path_label
export (NodePath) var path_spawn
export (NodePath) var path_timer
export (NodePath) var path_anim

onready var label = get_node(path_label)
onready var spawn = get_node(path_spawn)
onready var timer = get_node(path_timer)
onready var anim = get_node(path_anim)

onready var number_of_bubbles : int = initial_number_of_bubbles

func remove_bubble():
	number_of_bubbles -= 1
	label.text = String(number_of_bubbles)
	if number_of_bubbles <= 0:
		emit_signal("no_bubbles")

func _ready():
	spawn = get_node(spawn)
	label = get_node(label)
	timer = get_node(timer)
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
	
	remove_bubble()

func _on_button_toggled(button_toggle : bool):
	timer.start() if button_toggle else timer.stop()
