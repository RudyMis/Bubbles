extends Button

export (PackedScene) var ps_bubble_scanner
export (PackedScene) var ps_bubble
export (float) var joint_softness := 1.2
export (float) var hold_time := 2
export (Vector2) var max_scale := Vector2(1.5, 1.5)

var bubble_scanner = null

var bubbles_to_connect := Array()

# Łączy się z innymi bańkami w zasięgu
func connect_to_bubbles(bubble : Bubble):
	# Dzięki temu się mniej odbijają od siebie nawzajem w grupie
	if !bubbles_to_connect.empty(): bubble.physics_material_override = null
	for another_bubble in bubbles_to_connect:
		var joint = PinJoint2D.new()
		another_bubble.add_child(joint)
		joint.softness = joint_softness
		joint.node_a = joint.get_path_to(bubble)
		joint.node_b = joint.get_path_to(another_bubble)
	bubbles_to_connect.clear()

func disable(value : bool):
	disabled = value
	mouse_filter = 2 if value else 0

func _ready():
	pass # Replace with function body.

func _create_bubble_scanner():
	bubble_scanner = ps_bubble_scanner.instance()
	get_parent().add_child(bubble_scanner)
	
	bubble_scanner.connect("body_entered", self, "_on_bubble_collision")
	bubble_scanner.connect("body_exited", self, "_on_bubble_exited")
	bubble_scanner.connect("bubble_ready", self, "_release_bubble")
	
	bubble_scanner.set_position(get_viewport().get_mouse_position())
	bubble_scanner.start_growing(hold_time, max_scale)

func _release_bubble(bubble):
	if bubble == null: return
	get_tree().call_group("BubbleSpawner", "remove_bubble")
	
	bubble_scanner = null
	
	connect_to_bubbles(bubble)

func _on_button_released():
	if bubble_scanner == null: return
	bubble_scanner.stop_growing()

func _on_bubble_collision(body : Node):
	if body.is_class("Bubble"):
		bubbles_to_connect.push_back(body)

func _on_bubble_exited(body : Node):
	if bubbles_to_connect.has(body):
		bubbles_to_connect.erase(body)
