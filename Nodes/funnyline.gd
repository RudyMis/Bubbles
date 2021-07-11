extends Line2D

var cdown

func _ready():
	_init()

func _init():
	points[0] = Vector2(randf() * 640, randf() * 320)
	points[1] = Vector2(randf() * 640, points[0].y)
	print(points)
	cdown = Timer.new()
	add_child(cdown)
	cdown.wait_time = 20 * randf()
	cdown.connect("timeout", self, "_timeout")
	cdown.autostart = true
	visible = true

func _timeout():
	cdown.stop()
	print("nic")
	visible = !visible
	points[0] = Vector2(randf() * 640, randf() * 320)
	points[1] = Vector2(randf() * 640, points[0].y)
	cdown.wait_time = 15 * randf()
	cdown.start()
