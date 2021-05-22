extends Node2D

var platform = preload("res://scenes/Platform.tscn")
var enemy = preload("res://scenes/enemy.tscn")
var platy = 680
var platy2 = 250

func platform_spawn():
	var time

	var p = platform.instance()
	p.position.x = 1400
	platy = rand_range(50, 320)
	p.position.y = platy
	add_child(p)
	if platy < 0:
		time = rand_range(0.5, 1)
	elif platy >= 0:
		time = rand_range(0.8, 1.5)
	#elif platy > 125:
	#	time = rand_range(0.7, 1.2)
	#elif platy > 0:
	#	time = rand_range(1, 1.5)
	yield(get_tree().create_timer(time),"timeout")
	platform_spawn()

func platform_spawn2():
	var time

	var p = platform.instance()
	p.position.x = 1400
	platy2 = rand_range(430, 700)
	p.position.y = platy2
	add_child(p)
	if platy2 < 0:
		time = rand_range(0.5, 1)
	elif platy2 >= 0:
		time = rand_range(0.8, 1.5)
	#elif platy2 > 125:
	#	time = rand_range(0.7, 1.2)
	#elif platy2 > 0:
	#	time = rand_range(1, 1.5)
	yield(get_tree().create_timer(time),"timeout")
	platform_spawn2()

func enemy_spawn():
	yield(get_tree().create_timer(rand_range(2, 5)),"timeout")
	var e = enemy.instance()
	e.position.x = 1400
	e.position.y = randi()%711
	if global.enemy_count < 3:
		global.enemy_count += 1
		add_child(e)
	enemy_spawn()


func _ready():
	randomize()
	global.enemy_count = 0
	enemy_spawn()
	platform_spawn()
	platform_spawn2()
