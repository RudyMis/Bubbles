extends Particles2D

func kill_yourself():
	yield(get_tree().create_timer(lifetime), "timeout")
	queue_free()

func _ready():
	one_shot = true
	kill_yourself()
