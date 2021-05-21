extends StaticBody2D


var speed = 5

func _physics_process(delta):
	position.x -= speed
	if position.x < -100:
		queue_free()
