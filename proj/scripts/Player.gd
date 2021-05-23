extends KinematicBody2D


export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
var paper = preload("res://scenes/paper.tscn")
var dead = 0
var fade = 20

var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("shoot") and global.shoot >= 1:
		var p = paper.instance()
		p.position = get_node("rotate/displaced2").global_position
		p.rotation = $rotate.rotation
		get_parent().add_child(p)
		global.shoot -= 1

func _physics_process(delta):
	if global.shoot == 1:
		$ball.visible = true
		$ball2.visible = false
	elif global.shoot == 2:
		$ball2.visible = true
		$ball.visible = true
	else:
		$ball.visible = false
		$ball2.visible = false
	$rotate.look_at(get_global_mouse_position())
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	position.x -= global.speed


func _on_detectdead_area_entered(area):
	if dead == 0:
		dead = 1
		yield(get_tree().create_timer(0.5), "timeout")
		get_parent().get_node("fade").visible = true
		fade()

func fade():
	yield(get_tree().create_timer(0.02), "timeout")
	get_parent().get_node("fade").modulate.a += 0.05
	fade -=1
	if fade > 0:
		fade()
	else:
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()
		get_tree().change_scene("res://scenes/main menu.tscn")

