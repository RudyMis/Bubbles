extends CanvasLayer

export (float) var fade_time := 1.0
export (String) var radius_param_name := "radius"
export (String) var level_prefix := "res://scenes/levels/Level"
export (String) var menu_path := "res://scenes/levels/Intro.tscn"

var current_level_number := 1

onready var tween = $Tween
onready var buttons = $Gui
onready var color_rect : ColorRect = $ColorRect

func toggle_visible(value : bool):
	for child in get_children():
		if "visible" in child:
			child.set_visible(value)

func call_set_shader(value : float):
	color_rect.material.set_shader_param(radius_param_name, value)

func tween_fade(from : float, to : float, shader_time : float, buttons_time : float):
	tween.interpolate_method(
		self,
		"call_set_shader",
		from,
		to,
		fade_time,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		shader_time
	)
	tween.interpolate_property(
		buttons,
		"modulate:a",
		from,
		to,
		fade_time,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		buttons_time
	)
	tween.start()

func end_level():
	toggle_visible(true)
	tween_fade(0.0, 1.0, 0.0, fade_time)

func restart_level():
	color_rect.set_visible(true)
	tween_fade(0.0, 1.0, 0.0, 0.0)
	yield(tween, "tween_all_completed")
	
	var level_name = level_prefix + String(current_level_number) + ".tscn"
	
	get_tree().change_scene(level_name)
	tween_fade(1.0, 0.0, 0.0, 0.0)
	yield(tween, "tween_all_completed")
	color_rect.set_visible(false)

func next_level():
	current_level_number += 1
	var next_level_name = level_prefix + String(current_level_number) + ".tscn"
	get_tree().change_scene(next_level_name)
	tween_fade(1.0, 0.0, fade_time, 0.0)
	yield(tween, "tween_all_completed")
	toggle_visible(false)

func back():
	get_tree().change_scene(menu_path)
	tween_fade(1.0, 0.0, fade_time, 0.0)
	yield(tween, "tween_all_completed")
	toggle_visible(false)

func _ready():
	toggle_visible(false)
