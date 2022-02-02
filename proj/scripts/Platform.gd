extends StaticBody2D

var player = 0 #is player standing on the platform


func _physics_process(delta):
	position.x -= global.speed #moves platform towards left
	if position.x < -200:
		queue_free() #despawn when outside screen
		
	if (Input.is_action_pressed("drop") or global.control.y==-1) and player == 1: #code for player to drop
		#audio.get_node("drop").play()
		$collision.disabled = true
	else:
		$collision.disabled = false
		
	if global.hurt == 1:
		player = 0

func _on_dropdetect_body_entered(body):
	player = 1

func _on_dropdetect_body_exited(body):
	player = 0
