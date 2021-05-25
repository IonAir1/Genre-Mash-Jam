extends Node2D

var fade = 20 #fade timer
var play = 0 #is play button pressed
var credits = 0

func _ready():
	if global.score > global.highscore: #set new highscore code
		global.highscore = global.score

	$Control/VBoxContainer/score.text = "Score: " + str(global.score) #score text code
	$Control/VBoxContainer/highscore.text = "High Score: " + str(global.highscore) #highscore text code

	$fade.position = Vector2(660, 330) #setup fade in code
	fade_in()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func fade_out(scene): #fade out code
	yield(get_tree().create_timer(0.02), "timeout")
	$fade.modulate.a += 0.05
	fade -=1
	if fade > 0:
		fade_out(scene)
	else:
		yield(get_tree().create_timer(0.5), "timeout")
		get_tree().change_scene(scene) #switch to game screen

func fade_in(): #fade in code
	yield(get_tree().create_timer(0.02), "timeout")
	$fade.modulate.a -= 0.05
	fade -=1
	if fade > 0:
		fade_in()
	else:
		$fade.visible = false

func _on_Play_pressed(): #play button code
	if play == 0:
		audio.get_node("click").play()
		play = 1
		fade = 20 #setup fade out
		$fade.visible = true
		fade_out("res://scenes/main.tscn")

func _on_sound_pressed():
	if global.sound:
		global.sound = false
	else:
		global.sound = true

func _on_music_pressed():
	if global.music:
		global.music = false
	else:
		global.music = true

func _process(delta):
	if global.sound:
		$Control/sound.modulate.a = 1
	else:
		$Control/sound.modulate.a = 0.3
	if global.music:
		$Control/music.modulate.a = 1
	else:
		$Control/music.modulate.a = 0.3

func _on_Credits_pressed():
	if credits == 0:
		audio.get_node("click").play()
		credits = 1
		fade = 20 #setup fade out
		$fade.visible = true
		fade_out("res://scenes/Credits.tscn")

