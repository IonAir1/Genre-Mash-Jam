extends Node2D

var speed = 20 #bullet speed

func _physics_process(delta):
	position.x -= speed #moves bullet

	if position.x <= -50: #despawn when out of bounds
		queue_free()

func _process(delta):
	if global.hurt == 1: #despawn when respawning
		queue_free()


func _on_bullet_area_entered(area):
	queue_free() #despawn bullet when player touches
