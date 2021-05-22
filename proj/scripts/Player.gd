extends KinematicBody2D


export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
var paper = preload("res://scenes/paper.tscn")

var velocity = Vector2.ZERO

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += speed
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_just_pressed("shoot"):
		var p = paper.instance()
		p.position = position
		p.rotation = $rotate.rotation
		get_parent().add_child(p)

func _physics_process(delta):
	$rotate.rotation = (get_global_mouse_position() - $rotate.position).angle()
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed
	position.x -= 5
