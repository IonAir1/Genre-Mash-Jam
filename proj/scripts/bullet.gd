extends Node2D


func _physics_process(delta):
	position.x -= 40
	if position.x <= -50:
		queue_free()


func _on_bullet_area_entered(area):
	pass # Replace with function body.
