extends Node2D

var platform = preload("res://scenes/Platform.tscn")
var enemy = preload("res://scenes/enemy.tscn")
var platy = 0
var platy2 = 0
var fade = 20

func platform_spawn():
	var time = rand_range(0.8, 2.5)

	var p = platform.instance()
	p.position.x = 1400
	platy = randi()%4 + 1
	p.position.y = (64*platy) + 40
	add_child(p)
	yield(get_tree().create_timer(time),"timeout")
	platform_spawn()

func platform_spawn2():
	var time = rand_range(0.8, 2.5)

	var p = platform.instance()
	p.position.x = 1400
	platy2 = randi()%4 + 6
	p.position.y = (64*platy2) + 40
	add_child(p)
	yield(get_tree().create_timer(time),"timeout")
	platform_spawn2()

func enemy_spawn():
	var time
	if global.score < 10:
		time = 8 - (global.score/4)
	elif global.score >=10 and global.score < 20:
		time = 6.5 - ((global.score-9)/6)
	elif global.score >= 20 and global.score < 39:
		time = 4.8 - ((global.score - 19) / 10)
	else:
		time = 2;.8
	yield(get_tree().create_timer(time),"timeout")
	var e = enemy.instance()
	e.position.x = 1400
	
	var ypos
	ypos = (randi()%11)
	while global.enemypos[ypos] == 1:
		ypos = (randi()%11)
	e.position.y = (ypos * 64) + 48
	
	if global.enemy_count < 8:
		global.enemy_count += 1
		global.enemypos[ypos] = 1
		add_child(e)
		if global.enemy_count < 7:
			if randi()%4 == 0:
				var e1 = enemy.instance()
				e1.position.x = 1400
				e1.position.y = e.position.y - 64
				if e1.position.y > 0:
					if global.enemypos[ypos-1] == 0:
						global.enemy_count += 1
						add_child(e1)
					
				var e2 = enemy.instance()
				e2.position.x = 1400
				e2.position.y = e.position.y + 64
				if e2.position.y < 724:
					if global.enemypos[ypos+1] == 0:
						add_child(e2)
						global.enemy_count += 1
	enemy_spawn()

func _process(delta):
	if $Player.position.y <= -40:
		$ghostplayer.visible = true
	else:
		$ghostplayer.visible = false
	$score/score.text = "SCORE: " + str(global.score)

func _physics_process(delta):
	$ghostplayer.position.x = $Player.position.x
	$ghostplayer.scale.y = 1 + ($Player.position.y / 600)
	$ghostplayer.scale.x = 1 + ($Player.position.y / 600)

func _ready():
	randomize()
	$ghostplayer.position.y = -10
	$fade.position = Vector2(641, 315)
	global.enemy_count = 0
	global.score = 0
	global.shoot = 1
	enemy_spawn()
	platform_spawn()
	platform_spawn2()
	global.enemypos = [0,0,0,0,0,0,0,0,0,0,0]
	yield(get_tree().create_timer(0.5), "timeout")
	fade()

func fade():
	yield(get_tree().create_timer(0.02), "timeout")
	$fade.modulate.a -= 0.05
	fade -=1
	if fade > 0:
		fade()
	else:
		$fade.visible = false
