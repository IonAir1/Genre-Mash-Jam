extends KinematicBody2D


var velocity = Vector2(400, 400) #velocity of ball

func _ready():
	velocity = get_parent().get_node("Player/rotate/displaced").global_position - get_parent().get_node("Player").global_position
	velocity.normalized() #sets up direction and speed of ball
	velocity = velocity*120
	pass

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta) #movement of ball
	if collision_info:
		velocity = velocity.bounce(collision_info.normal) #bouncing of ball

func _on_playerdetect_body_entered(body):
	global.shoot += 1
	queue_free() #despawn ball when picked up by player
	pass

func _on_killballdetect_area_entered(area):
	global.shoot += 1
	queue_free()  #despawn ball when it goes out of bounds

func _process(delta):
	if global.hurt == 1:
		queue_free() #despawns ball when player dies
