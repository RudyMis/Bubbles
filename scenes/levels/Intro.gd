extends Control

func _ready():
	$A1/AnimationPlayer.play("funnyletters")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _STARTDAGAME():
	get_tree().change_scene("res://scenes/levels/Level1.tscn")

func _on_cr_button_pressed():
	$A1.visible = false
	$ACR.visible = true


func _on_A1pl_button_pressed():
	_STARTDAGAME()
func _on_ACRpl_button_pressed():
	_STARTDAGAME()
