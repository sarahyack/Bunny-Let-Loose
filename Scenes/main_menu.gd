extends Node

const main_game: PackedScene = preload("res://Scenes/game.tscn")
const computer_controls: Array[String] = ["A, D to move", "Space to Jump", "Left-Click to Shoot"]
const joypad_controls: Array[String] = ["Left Joystick to move", "A to Jump", "Right Trigger to Shoot"]
const touchscreen_controls: Array[String] = ["Joystick to move", "Tap Up Button to Jump", "Tap to Shoot"]

func _ready():
	if Input.get_connected_joypads().size() != 0:
		change_controls(2)
		$Menu/VBoxContainer/MarginContainer/Play.grab_focus()
	elif DisplayServer.is_touchscreen_available():
		change_controls(1)
	else:
		change_controls(0)
	

func _input(event):
	if Input.get_connected_joypads().size() != 0:
		var focused = get_viewport().gui_get_focus_owner()
		if event.is_action_pressed("select"):
			focused.pressed.emit()
	
	if event.is_action_pressed("back"):
		get_tree().quit()

func change_controls(id: int):
	var array := computer_controls
	
	match id:
		0:
			array = computer_controls
		1:
			array = touchscreen_controls
		2:
			array = joypad_controls
	
	$Menu/Panel/VBoxContainer/Move.text = array[0]
	$Menu/Panel/VBoxContainer/Jump.text = array[1]
	$Menu/Panel/VBoxContainer/Shoot.text = array[2]
	


func _on_play_pressed():
	get_tree().change_scene_to_packed(main_game)


func _on_controls_pressed():
	$Menu/Panel.visible = not $Menu/Panel.visible
