extends Node2D

func _ready():
	global.control = Vector3.ZERO

func _process(delta):
	global.control = Vector3.ZERO
	if $Right.is_pressed():
		if $Left.is_pressed():
			global.control.x = 0
		else:
			global.control.x = 1
	elif $Left.is_pressed():
		global.control.x = -1
	else:
		global.control.x = 0
	
	if $Top.is_pressed():
		global.control.y = 1
	elif $Down.is_pressed():
		global.control.y = -1
	else:
		global.control.y = 0


func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		global.control.z = 1
