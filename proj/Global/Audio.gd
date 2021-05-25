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
