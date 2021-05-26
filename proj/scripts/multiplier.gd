extends Node2D

func _ready():
	$label.text = str(global.multiplier) + "x" #set text
	alpha()

func alpha():
	yield(get_tree().create_timer(0.05), "timeout") #slowly fade away
	modulate.a -= 0.02
	alpha()

func _process(delta):
	if global.hurt == 1: #despawn when respawning
		queue_free()
	if modulate.a <= 0: #disappear when faded out
		queue_free()
	if global.multiplier > 1:
		visible = true
