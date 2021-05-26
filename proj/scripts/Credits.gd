extends Control

func _on_LinkButton_pressed(): #open webpage when clicked
	OS.shell_open("https://www.fesliyanstudios.com/")

func _input(event): #go back to main menu when key press
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER:
			audio.get_node("click").play()
			get_tree().change_scene("res://scenes/main menu.tscn")
