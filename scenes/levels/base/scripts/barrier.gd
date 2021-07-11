extends Node2D

# Szerokosc belki. Nie zmieniac jej w edytorze, tylko wpisac.
export var width = 12

func _ready():
	var k = width - 8
	$left.position = Vector2(-2 - k/2, 0)
	$right.position = Vector2(2 + k/2, 0)
	$center.scale = Vector2(width / 4, 1)
	pass # Replace with function body.
