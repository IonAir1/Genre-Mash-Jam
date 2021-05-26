extends Node

func _ready():
	randomize()
	if randi()%2 == 0: #randomly pick which song gets played first
		play_0()
	else:
		play_1()

func play_0(): #play music 1
	$music0.play()

func play_1(): #play music 0
	$music1.play()

func _on_music1_finished(): #after playing music 0
	play_0() #play music 1

func _on_music0_finished(): #after playing music 1
	play_1() #play music 0

func _process(delta):
	if global.sound: #code for turning sounds on and off
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

	if global.music: #code for turning music on and off
		$music0.volume_db = -8
		$music1.volume_db = -8
	else:
		$music0.volume_db = -80
		$music1.volume_db = -80
