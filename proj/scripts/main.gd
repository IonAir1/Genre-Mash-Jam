extends Node2D

var platform = preload("res://scenes/Platform.tscn")
var enemy = preload("res://scenes/enemy.tscn")
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


func enemy_spawn():
	var e = enemy.instance()
	e.position.x = 1400
	e.position.y = randi()%711
	add_child(e)
	yield(get_tree().create_timer(rand_range(2, 5)),"timeout")
	enemy_spawn()


func _ready():
	randomize()
	enemy_spawn()
	platform_spawn()
