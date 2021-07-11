extends Node2D

func _ready():
	var line = load("res://Nodes/funnyline.tscn")
	for i in range(0, 20):
		var me = line.instance()
		add_child(me)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
