extends KinematicBody2D


var speed = 600 #player speed
var jump_speed_normal = -1000 #-1500 #player initial jump height
var jump_speed_var = -50 #added jump for variable jump
var gravity = 4000 #gravity
var paper = preload("res://scenes/paper.tscn") #ball scene (paper and ball are same)
var dead = 0 #lost game
var fade = 20 #fade in and out / scene transition
var respawning = 0 #is player respawning
var jump = 0 #player jump timer
var velocity = Vector2.ZERO #velocity

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"): #move right
		velocity.x += speed

	if Input.is_action_pressed("left"): #move left
		velocity.x -= speed

	if Input.is_action_just_pressed("shoot") and global.shoot >= 1: #shoot or throw ball
		if not (global.tutorial and respawning == 1):
			var p = paper.instance()
			p.position = get_node("rotate/displaced3").global_position #to make it so ouse distance does not affect speed of ball
			p.rotation = $rotate.rotation
			get_parent().add_child(p)
			global.shoot -= 1

func _physics_process(delta):
	$rotate.look_at(get_global_mouse_position()) #rotates 'rotate' node to cursor for aiming

	get_input() #movement
	velocity.y += gravity * delta
	jump()
	velocity.normalized()
	velocity = move_and_slide(velocity, Vector2.UP)

	if respawning == 0: #moves player to the left
		position.x -= global.speed

func jump(): #code for jumping
	if Input.is_action_pressed("jump"):
		if is_on_floor(): #initial jump
			audio.get_node("jump").play()
			jump = 0
			velocity.y += jump_speed_normal
		else: #added jump
			if respawning == 0:
				if jump <= 10:
					jump += 1
					velocity.y += jump_speed_var
				if jump > 10 and jump <= 20:
					jump + 1
					velocity.y += jump_speed_var/2

func _on_detectdead_area_entered(area): #detect if player hit
	if dead == 0 and global.lives <= 0: #if no more lives
		visible = false
		dead = 1
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().get_node("fade").visible = true
		fade() #fade out
	else: #if still has lives
		if area.name == "player wall": #if died because of player wall
			position.y = -200 #respawn
			position.x = 640

			gravity = 0
			velocity.y = 0
			respawning = 1
			if not global.tutorial:
				global.lives -= 10
				global.shoot = 0
			global.hurt = 1
			audio.get_node("fall").play()
		else: #if died because of bullet or enemy type 2
			global.shake = 1
			audio.get_node("hurt").play()
		reset_grav()
		global.multiplier = 0
		if not global.tutorial:
			global.lives -= 10
		yield(get_tree().create_timer(0.01), "timeout")
		global.hurt = 0

func _process(delta):
	global.playerpos = position #make player position known globally

	if global.shoot == 1: #code for handling player holding the ball
		$ball.visible = true
		$ball2.visible = false
	elif global.shoot == 2:
		$ball2.visible = true
		$ball.visible = true
	else:
		$ball.visible = false
		$ball2.visible = false

func reset_grav(): #after respawning, gravity must reset
	yield(get_tree().create_timer(4), "timeout")
	gravity = 4000
	if not global.tutorial:
		global.shoot = 1
	respawning = 0

func fade(): #fade out
	yield(get_tree().create_timer(0.02), "timeout")
	get_parent().get_node("fade").modulate.a += 0.05
	fade -=1
	if fade > 0:
		fade()
	else:
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()
		get_tree().change_scene("res://scenes/main menu.tscn") #back to main menu



