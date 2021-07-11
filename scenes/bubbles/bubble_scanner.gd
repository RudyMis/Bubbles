extends Area2D

signal bubble_ready

export (PackedScene) var ps_bubble
export (NodePath) var path_tween

onready var tween = get_node(path_tween)

func stop_growing():
	if ps_bubble == null: return
	var bubble = ps_bubble.instance()
	bubble.position = position
	bubble.rescale(scale)
	get_parent().add_child(bubble)
	emit_signal("bubble_ready", bubble)
	$sfx_inflate.stop()
	call_deferred("queue_free")

func start_growing(grow_time : float, max_scale : Vector2):
	if tween == null: return
	$sfx_inflate.play()
	tween.remove_all()
	tween.interpolate_property(
		self,
		"scale",
		Vector2(0.25, 0.25),
		max_scale,
		grow_time,
		Tween.TRANS_SINE,
		Tween.EASE_OUT
	)
	tween.start()

func _ready():
	pass

func _tween_all_completed():
	stop_growing()
