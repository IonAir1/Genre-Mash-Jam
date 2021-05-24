extends KinematicBody2D

var speed = 80
var prev = 0
var curr = 0

func _ready():
	pass

func _process(delta):
	if global.hurt == 1: #despawn when player respawning
		queue_free()

func _physics_process(delta):
	look_at(global.playerpos)
	var velocity = global_position.direction_to(global.playerpos)
	if velocity.x > 0:
		move_and_slide(position.direction_to(global.playerpos) * speed)
	elif velocity.x < 0 :
		move_and_slide(position.direction_to(global.playerpos) * speed * 4)

func _on_detect_body_entered(body):
	if body.name == "paper":
		play()
		global.score += 1
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
