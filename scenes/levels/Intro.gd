extends Control

func _ready():
	$A1/AnimationPlayer.play("funnyletters")

func _STARTDAGAME():
	SceneChanger.restart_level()

func _on_cr_button_pressed():
	$A1.visible = false

func _on_A1pl_button_pressed():
	_STARTDAGAME()
func _on_ACRpl_button_pressed():
	_STARTDAGAME()
func _on_ATUpl_button_pressed():
	_STARTDAGAME()

func _on_ACRtu_button_pressed():
	$A1.visible = false
	$ACR.visible = false
func _on_A1tu_button_pressed():
	$A1.visible = false
	$ACR.visible = false


func _on_exit():
	get_tree().quit()
