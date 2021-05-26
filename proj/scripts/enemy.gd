extends KinematicBody2D

var bullet = preload("res://scenes/bullet.tscn") #bullet scene
var mp = preload("res://scenes/multiplier.tscn") #multiplier scene
var curr = 0
var limit = 30

func _ready():
	yield(get_tree().create_timer(2), "timeout")
	bullet() #start shooting bullets

func bullet(): #bullet spawn code
	yield(get_tree().create_timer(rand_range(1.2, 3)), "timeout") #spawn bullets
	var b = bullet.instance()
	b.position = position
	if not global.tutorial:
		get_parent().add_child(b)
	bullet()

func _process(delta): 
	if curr < limit: #move enemy from side of screen
		position.x -= 5
		curr += 1
	if global.hurt == 1 and not global.tutorial: #despawn when player respawning
		queue_free()

func _on_detect_body_entered(body): #despawn when hit by ball
	if body.name == "paper":
		play()
		if global.multiplier > 0.5:
			global.score += global.multiplier
		else:
			global.score += 1
		global.enemy_count -= 1
		var ypos = (position.y - 40) / 64
		global.enemypos[ypos] = 0
		global.mpupdate += 1
		yield(get_tree().create_timer(0.05), "timeout")

		var m = mp.instance()
		m.position = position
		get_parent().add_child(m)

		if global.tutorial:
			global.tutolevel = 2

		queue_free()

func play(): #play enemy sounds
	if global.enemysound == 0:
		global.enemysound = 1
		audio.get_node("enemyhit").play()
		yield(get_tree().create_timer(0.3), "timeout")
		global.enemysound = 0

func _on_Area2D_body_entered(body):
	yield(get_tree().create_timer(0.05), "timeout")
	queue_free()
