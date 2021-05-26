extends KinematicBody2D

var speed = 80 #speed
var mp = preload("res://scenes/multiplier.tscn") #multiplier scene
var move = 1 #can move?

func _process(delta):
	if global.hurt == 1: #despawn when player respawning
		queue_free()

func _physics_process(delta):
	look_at(global.playerpos) #look towards player
	var velocity = global_position.direction_to(global.playerpos)
	if move == 1: #move to player
		if velocity.x > 0:
			move_and_slide(position.direction_to(global.playerpos) * speed)
		elif velocity.x < 0 :
			move_and_slide(position.direction_to(global.playerpos) * speed * 4)

func _on_detect_body_entered(body):
	if body.name == "paper": #despawn when hit with ball
		move = 0
		play()
		if global.multiplier > 0.5: #activate multiplier
			global.score += global.multiplier
		else:
			global.score += 1
		global.mpupdate += 1
		yield(get_tree().create_timer(0.05), "timeout")

		var m = mp.instance() 
		m.position = position
		get_parent().add_child(m)

		queue_free()

func play(): #play sound for enemy hit
	if global.enemysound == 0:
		global.enemysound = 1
		audio.get_node("enemyhit").play()
		yield(get_tree().create_timer(0.3), "timeout")
		global.enemysound = 0

func _on_Area2D_body_entered(body): #despawn when player gets hurt
	yield(get_tree().create_timer(0.05), "timeout")
	queue_free()
