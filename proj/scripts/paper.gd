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
		global.shake = 2 #screenshake
		audio.get_node("bounce").play() #play bounce sound
		velocity = velocity.bounce(collision_info.normal) #bouncing of ball

func _on_playerdetect_body_entered(body): #picked up by player
	global.shoot += 1
	audio.get_node("pickup").play() #play pickup sound
	
	if global.tutolevel == 2: #finish tutorial
		global.tutolevel = -1
		global.tutorial = false
		global.spawn = true
	
	queue_free() #despawn ball when picked up by player
	pass

func _on_killballdetect_area_entered(area):
	global.shoot += 1
	queue_free()  #despawn ball when it goes out of bounds

func _process(delta):
	if global.hurt == 1 and not global.tutorial:
		queue_free() #despawns ball when player dies


