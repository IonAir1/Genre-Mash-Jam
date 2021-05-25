extends Node

func _ready():
	randomize()
	if randi()%2 == 0:
		play_0()
	else:
		play_1()

func play_0():
	$music0.play()

func play_1():
	$music1.play()

func _on_music1_finished():
	play_0()

func _on_music0_finished():
	play_1()

func _process(delta):
	if global.sound:
		$bounce.volume_db = 0
		$enemyhit.volume_db = 2
		$jump.volume_db = -5
		$pickup.volume_db = 0
		$hurt.volume_db = 0
		$fall.volume_db = 0
		$drop.volume_db = 0
		$click.volume_db = 0
	else:
		$bounce.volume_db = -80
		$enemyhit.volume_db = -80
		$jump.volume_db = -80
		$pickup.volume_db = -80
		$hurt.volume_db = -80
		$fall.volume_db = -80
		$drop.volume_db = -80
		$click.volume_db = -80

	if global.music:
		$music0.volume_db = -8
		$music1.volume_db = -8
	else:
		$music0.volume_db = -80
		$music1.volume_db = -80
