extends Control

var fade = 20
var click = 0

func _on_LinkButton_pressed(): #open webpage when clicked
	OS.shell_open("https://www.fesliyanstudios.com/")

func _input(event): #go back to main menu when key press
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER:
			if click == 0:
				audio.get_node("click").play()
				click = 1
				fade = 20 #setup fade out
				$fade.visible = true
				fade_out("res://scenes/main menu.tscn")


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
		
func _ready():
	fade_in()
