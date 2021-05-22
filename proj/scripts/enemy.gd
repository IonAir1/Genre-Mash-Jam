extends KinematicBody2D

var bullet = preload("res://scenes/bullet.tscn")

func _ready():
	
	for i in range(20):
		position.x -= 10
	bullet()


func bullet():
	yield(get_tree().create_timer(rand_range(0.6, 2)), "timeout")
	var b = bullet.instance()
	b.position = position
	get_parent().add_child(b)
	bullet()


func _on_detect_body_entered(body):
	yield(get_tree().create_timer(0.01), "timeout")
	print(body.name)
	if body.name == "paper":
		queue_free()
