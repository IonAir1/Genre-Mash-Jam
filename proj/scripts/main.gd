extends Node2D

var platform = preload("res://scenes/Platform.tscn") #platform scene
var enemy = preload("res://scenes/enemy.tscn") #enemy scene
var platy = 0 #upper platform grid position
var platy2 = 0 #lower platform grid position
var fade = 20 #fade timer
var enemy2 = preload("res://scenes/enemy2.tscn")
var mptime = 0
var mpcount = 0
var timerlimit = 5

func platform_spawn():#platform spawner for platforms on the upper half of screen
	var time = rand_range(0.8, 2) #timing of platform spawn

	var p = platform.instance() #sets up position of platform
	p.position.x = 1400
	platy = randi()%4 + 1 #sets grid position
	p.position.y = (64*platy) + 40 #sets y position of grid

	add_child(p)#spawns platform

	yield(get_tree().create_timer(time),"timeout")
	platform_spawn()

func platform_spawn2(): #platform spawner for platforms on the lower half of screen
	var time = rand_range(0.8, 2) #timing of platform spawn

	var p = platform.instance() #sets up position of platform
	p.position.x = 1400
	platy2 = randi()%4 + 6 #sets grid position
	p.position.y = (64*platy2) + 40 #sets y position of grid

	add_child(p)#spawns platform

	yield(get_tree().create_timer(time),"timeout")
	platform_spawn2()

func enemy_spawn(): #enemy spawner
	var time #sets timing of platform
	if global.score < 50:
		time = 8 - (global.score/20)
	elif global.score >=50 and global.score < 150:
		time = 6.5 - ((global.score-50)/60)
	elif global.score >= 150 and global.score <= 250:
		time = 4 - ((global.score - 150) / 167)
	else:
		time = 2.5
	yield(get_tree().create_timer(time),"timeout")

	if randi()%3 == 2:
		var e = enemy2.instance()
		e.position.x = 1400
		e.position.y = global.playerpos.y
		add_child(e)

	else:
		var e = enemy.instance() #sets up and spawns enemy
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
				if randi()%4 == 0: #25% chance of enemy formation
					
					var e1 = enemy.instance() #spawns new enemy above orig enemy
					e1.position.x = 1400
					e1.position.y = e.position.y - 64
					if e1.position.y > 0:
						if global.enemypos[ypos-1] == 0: #checks if there is already enemy in place
							global.enemy_count += 1
							add_child(e1)


					var e2 = enemy.instance() #spawns new enemy below orig enemy
					e2.position.x = 1400
					e2.position.y = e.position.y + 64
					if e2.position.y < 724:
						if global.enemypos[ypos+1] == 0: #checks if there is already enemy in place
							add_child(e2)
							global.enemy_count += 1

	enemy_spawn()

func _process(delta):
	if $Player.position.y <= -40: #code for hiding and showing out of bounds indicator
		$ghostplayer.visible = true
	else:
		$ghostplayer.visible = false

	$score/score.text = "SCORE: " + str(global.score) #sets text of score label

	$health.value = global.lives + 1 #sets value of healthbar

	if global.multiplier > 1:
		$mp.visible = true
		$mp.text = str(global.multiplier) + "x"
	else:
		$mp.visible = false

	if global.mpupdate >= 1:
		global.mpupdate -= 1
		if global.multiplier > 0.5:
			mptime = 0
		else:
			mptime = 0
			mpcount = 1
		if global.multiplier >= 5:
			global.multiplier = global.multiplier + 5
		elif global.multiplier > 1:
			global.multiplier = 5
		else:
			global.multiplier += 1

	if global.hurt == 1:
		mptime == 0
		mpcount = 0
	
	

func mptimer():
	var time = 0.1
	yield(get_tree().create_timer(time), "timeout")
	if mpcount == 1:
		mptime += time
		if mptime >= timerlimit:
			mptime = 0
			mpcount = 0
			global.multiplier = 0
	mptimer()

func _physics_process(delta):
	$cursor.position = get_global_mouse_position()
	$ghostplayer.position.x = $Player.position.x #moves and scales out of bound player indicator
	$ghostplayer.scale.y = 1 + ($Player.position.y / 600)
	$ghostplayer.scale.x = 1 + ($Player.position.y / 600)

func _ready():
	randomize() #randomizes things
	global.lives = 100 #setups / resets global variables
	$ghostplayer.position.y = -10
	$fade.position = Vector2(641, 315)
	global.enemy_count = 0
	global.score = 0
	global.shoot = 1
	global.enemypos = [0,0,0,0,0,0,0,0,0,0,0]
	global.enemysound = 0
	global.multiplier = 0
	global.mpupdate = 0
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	if not global.tutorial:
		enemy_spawn() #initiates spawner codes
	platform_spawn()
	platform_spawn2()
	mptimer()
	yield(get_tree().create_timer(0.5), "timeout")
	fade()

func fade(): #code for fade in / scene transition
	yield(get_tree().create_timer(0.02), "timeout")
	$fade.modulate.a -= 0.05
	fade -=1
	if fade > 0:
		fade()
	else:
		$fade.visible = false
