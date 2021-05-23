extends KinematicBody2D

var bullet = preload("res://scenes/bullet.tscn")

func _ready():
	for i in range(15):
		position.x -= 10
	yield(get_tree().create_timer(2), "timeout")
	bullet()


func bullet():
	yield(get_tree().create_timer(rand_range(0.8, 2)), "timeout")
	var b = bullet.instance()
	b.position = position
	get_parent().add_child(b)
	bullet()

func _process(delta):
	if global.hurt == 1:
		queue_free()

func _on_detect_body_entered(body):
	yield(get_tree().create_timer(0.01), "timeout")
	if body.name == "paper":
		global.score += 1
		global.enemy_count -= 1
		var ypos = (position.y - 40) / 64
		global.enemypos[ypos] = 0
		queue_free()
