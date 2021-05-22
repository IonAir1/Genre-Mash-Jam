extends StaticBody2D




func _physics_process(delta):
	position.x -= global.speed
	if position.x < -100:
		queue_free()
