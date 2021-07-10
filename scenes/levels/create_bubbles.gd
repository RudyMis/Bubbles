extends Button

export (PackedScene) var ps_bubble_scanner
export (PackedScene) var ps_bubble
export (float) var joint_softness := 1.2
export (float) var hold_time := 2

var tween = null
var new_bubble_scanner = null

var bubbles_to_connect := Array()

func _create_bubble_scanner():
	new_bubble_scanner = ps_bubble_scanner.instance()
	new_bubble_scanner.connect("body_entered", self, "_on_bubble_collision")
	new_bubble_scanner.connect("body_exited", self, "_on_bubble_exited")
	get_parent().add_child(new_bubble_scanner)
	new_bubble_scanner.set_position(get_viewport().get_mouse_position())
	
	tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed", self, "_release_bubble")
	tween.interpolate_property(
		new_bubble_scanner,
		"scale",
		Vector2(0.25, 0.25),
		Vector2(1.5, 1.5),
		hold_time,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	tween.start()

func _release_bubble():
	
	if new_bubble_scanner == null: return
	
	var new_bubble = ps_bubble.instance()
	get_parent().add_child(new_bubble)
	
	new_bubble.position = new_bubble_scanner.position
	new_bubble.rescale(new_bubble_scanner.scale)
	connect_to_bubbles(new_bubble)
	
	tween.stop_all()
	tween.queue_free()
	tween = null
	
	new_bubble_scanner.queue_free()
	new_bubble_scanner = null

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

func _ready():
	pass # Replace with function body.

func _on_bubble_collision(body : Node):
	if body.is_class("Bubble"):
		bubbles_to_connect.push_back(body)

func _on_bubble_exited(body : Node):
	if bubbles_to_connect.has(body):
		bubbles_to_connect.erase(body)
