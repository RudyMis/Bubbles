extends AnimatedSprite

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
		$o2button.play("nobub")
		stop()
		frame = 0

func _ready():
	label.text = String(number_of_bubbles)
	$o2button.play("ok")

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

func _on_button_toggled(button_toggle : bool):
	timer.start() if button_toggle else timer.stop()
	if button_toggle:
		if label.text == "0":		# Okropne
			$o2button.play("nobub")
		else:
			$o2button.play("blow")
		play("plumm")
	else:
		stop()
		if label.text == "0":		# Okropne
			$o2button.play("nobub")
		else:
			$o2button.play("ok")
		frame = 0

# o2button - kosmetyka



func _on_Guzik_button_down():
	$o2button.position = Vector2(0, 6)

func _on_Guzik_button_up():
	$o2button.position = Vector2(0, 7)
