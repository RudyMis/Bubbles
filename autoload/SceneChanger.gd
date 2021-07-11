extends ColorRect

export (float) var fade_time := 0.5
export (String) var radius_param_name := "radius"
onready var tween = $Tween

func call_set_shader(value : float):
	print("Dzień dobry")
	material.set_shader_param(radius_param_name, value)

func end_level():
	print("Plum")
	tween.interpolate_method(
		self,
		"call_set_shader",
		1.0,
		0.0,
		fade_time,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
	)
	tween.start()

func _ready():
	end_level()
