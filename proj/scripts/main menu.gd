extends Node2D

var fade = 20

func _ready():
	if global.score > global.highscore:
		global.highscore = global.score
	$Control/VBoxContainer/score.text = "Score: " + str(global.score)
	$Control/VBoxContainer/highscore.text = "High Score: " + str(global.highscore)
	$fade.position = Vector2(660, 330)
	fade_in()

func fade_out():
	yield(get_tree().create_timer(0.02), "timeout")
	$fade.modulate.a += 0.05
	fade -=1
	if fade > 0:
		fade_out()
	else:
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene("res://scenes/main.tscn")

func fade_in():
	yield(get_tree().create_timer(0.02), "timeout")
	$fade.modulate.a -= 0.05
	fade -=1
	if fade > 0:
		fade_in()
	else:
		$fade.visible = false

func _on_Play_pressed():
	fade = 20
	$fade.visible = true
	fade_out()
