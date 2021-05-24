extends Node2D



func _ready():
	$label.text = str(global.multiplier) + "x"
	alpha()

func alpha():
	yield(get_tree().create_timer(0.05), "timeout")
	modulate.a -= 0.02
	alpha()

func _process(delta):
	if global.hurt == 1:
		queue_free()
	if modulate.a <= 0:
		queue_free()
	if global.multiplier > 1:
		visible = true
