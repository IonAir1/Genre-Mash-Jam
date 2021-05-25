extends Node

func _ready():
	randomize()
	if randi()%2 == 0:
		play_0()
	else:
		play_1()

func play_0():
	$music0.play()
	yield($music0, "finished")
	play_1()

func play_1():
	$music1.play()
	yield($music1, "finished")
	play_0()
