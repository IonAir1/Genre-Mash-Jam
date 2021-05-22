extends Node2D

var platform = preload("res://scenes/Platform.tscn")
var platy = 680

func platform_spawn():
	var time

	var p = platform.instance()
	p.position.x = 1400
	if platy < 250:
		platy = platy + rand_range(0, 250)
	elif platy > 450:
		platy = platy + rand_range(-250, 0)
	else:
		platy = platy + rand_range(-250, 250)
	p.position.y = platy
	add_child(p)
	if platy < -125:
		time = rand_range(0.3, 0.8)
	elif platy < 0:
		time = rand_range(0.5, 1)
	elif platy > 125:
		time = rand_range(0.7, 1.2)
	elif platy > 0:
		time = rand_range(1, 1.5)
	yield(get_tree().create_timer(time),"timeout")
	platform_spawn()

func _ready():
	randomize()
	platform_spawn()
