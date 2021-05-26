extends Node2D

func _ready():
	if global.score > global.highscore: #set new highscore code
		global.highscore = global.score

	$Control/VBoxContainer/score.text = "Score: " + str(global.score) #score text code
	$Control/VBoxContainer/highscore.text = "High Score: " + str(global.highscore) #highscore text code

	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Play_pressed(): #play button code
	audio.get_node("click").play()
	get_tree().change_scene("res://scenes/main.tscn")

func _on_sound_pressed(): #sound button code
	if global.sound:
		global.sound = false
	else:
		global.sound = true

func _on_music_pressed(): #music button code
	if global.music:
		global.music = false
	else:
		global.music = true

func _process(delta):
	if global.sound: #highlghting music and sound button
		$Control/sound.modulate.a = 1
	else:
		$Control/sound.modulate.a = 0.3
	if global.music:
		$Control/music.modulate.a = 1
	else:
		$Control/music.modulate.a = 0.3

func _on_Credits_pressed():
	audio.get_node("click").play()
	get_tree().change_scene("res://scenes/Credits.tscn")

