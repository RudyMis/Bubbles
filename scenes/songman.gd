extends Sprite

var songs = ["res://assets/sound/music/tearoo.ogg", "res://assets/sound/music/atrocitizen.ogg", "res://assets/sound/music/patataika.ogg", "res://assets/sound/music/malaxer.ogg"]
var songfiles
var current
var doubleplay
var playing

func _ready():
	songfiles = [load(songs[0]), load(songs[1]), load(songs[2]), load(songs[3])]
	current = randi() % 4
	doubleplay = false
	playing = true
	current = randi() % 4
	$song.stream = songfiles[current]
	$song.volume_db = 1
	_on_song_finished()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_song_finished():
	if doubleplay:
		var old = current
		while old == current:
			current = randi() % 4
		$song.stream = songfiles[current]
	$song.play()
	$Label.text = String(current + 1)
	doubleplay = !doubleplay

func _on_playpause_toggle(button_pressed):
	print("0pp")
	if button_pressed:
		$Label.text = "||"
	else:
		$Label.text = String(current + 1)
	$song.stream_paused = !($song.stream_paused)
	playing = !button_pressed

func _on_next_pressed():
	doubleplay = true
	_on_song_finished()
