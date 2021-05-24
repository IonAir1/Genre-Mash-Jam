extends KinematicBody2D

var bullet = preload("res://scenes/bullet.tscn") #bullet scene
var mp = preload("res://scenes/multiplier.tscn")

func _ready():
	for i in range(15): #move enemy on screen from side
		position.x -= 10
	yield(get_tree().create_timer(2), "timeout")
	bullet() #start shooting bullets

func bullet():
	yield(get_tree().create_timer(rand_range(1.2, 3)), "timeout") #spawn bullets
	var b = bullet.instance()
	b.position = position
	get_parent().add_child(b)
	bullet()

func _process(delta):
	if global.hurt == 1: #despawn when player respawning
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

		queue_free()

func play():
	if global.enemysound == 0:
		global.enemysound = 1
		audio.get_node("enemyhit").play()
		yield(get_tree().create_timer(0.3), "timeout")
		global.enemysound = 0

func _on_Area2D_body_entered(body):
	yield(get_tree().create_timer(0.05), "timeout")
	queue_free()
