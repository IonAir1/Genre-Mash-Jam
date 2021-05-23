extends KinematicBody2D


var velocity = Vector2(400, 400)

func _ready():
	velocity = get_parent().get_node("Player/rotate/displaced").global_position - get_parent().get_node("Player").global_position
	velocity.normalized()
	velocity = velocity*120
	pass

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)


func _on_playerdetect_body_entered(body):
	global.shoot += 1
	queue_free()
	pass


func _on_killballdetect_area_entered(area):
	global.shoot += 1
	queue_free()

func _process(delta):
	if global.hurt == 1:
		queue_free()
