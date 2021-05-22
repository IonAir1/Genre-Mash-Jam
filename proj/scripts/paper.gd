extends KinematicBody2D


var velocity = Vector2(400, 400)

func _ready():
	velocity = get_global_mouse_position().normalized() - get_parent().get_node("Player").position.normalized()
	velocity.normalized()
	velocity = velocity*400
	print(velocity)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)


func _on_playerdetect_body_entered(body):
	#queue_free()
	pass
