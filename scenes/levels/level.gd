extends CanvasLayer

var placing_trampolines = false
var l
var start_point
# Można dodać jakiś lock, żeby budować albo trampolinę, albo nową bańkę.
# Teraz jest ustawiony na prawy przycisk myszy:
var hotkey = BUTTON_RIGHT

func _ready():
	l = Line2D.new()
	l.set_default_color(Color(1,0,0))
	l.width = 2
	l.points = PoolVector2Array(Vector2(0, -1))

func _process(delta):
	if l.points.size() == 2:
		print('b')
		l.points = PoolVector2Array(start_point, get_viewport().get_mouse_position())

func _input(event):
	# Przełączanie między idle i budowaniem trampolin.
	if event.is_class("InputEventKey") and event.is_pressed():
		var k = event.get_scancode()
		if k == KEY_T:
			placing_trampolines = !placing_trampolines
			$tramp_ind.visible = placing_trampolines
	if event.is_class("InputEventMouseButton"):
		if event.get_button_mask() == hotkey:
			start_point = event.position
			l.points = PoolVector2Array(start_point, Vector2(0,0))
