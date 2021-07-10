extends Node



export (PackedScene) var ps_bubble
export (PackedScene) var ps_bubble_scanner
var tween = null
var new_bubble_scanner = null

func create_bubble_scanner():
	new_bubble_scanner = ps_bubble_scanner.instance()
	new_bubble_scanner.connect("body_entered", self, "_on_bubble_collision")
	get_parent().add_child(new_bubble_scanner)
	new_bubble_scanner.set_position(get_viewport().get_mouse_position())
	
	tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed", self, "release_bubble")
	tween.interpolate_property(
		new_bubble_scanner,
		"scale",
		Vector2(0.25, 0.25),
		Vector2(1.5, 1.5),
		5,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	tween.start()

func release_bubble():
	var new_bubble = ps_bubble.instance()
	get_parent().add_child(new_bubble)
	new_bubble.position = new_bubble_scanner.position
	new_bubble.rescale(new_bubble_scanner.scale)
	
	tween.stop_all()
	tween.queue_free()
	tween = null
	
	new_bubble_scanner.set_visible(false)
#	new_bubble_scanner.queue_free()
	# TODO podłączanie sie do innych

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if tween == null:
			create_bubble_scanner()

	if event.is_action_released("Click"):
		if tween != null:
			release_bubble()

func _ready():
	pass # Replace with function body.

func _on_bubble_collision(body : Node):
	pass
