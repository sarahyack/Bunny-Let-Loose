extends Node

var main_game: PackedScene = load("res://Scenes/game.tscn")
var menu_scene: PackedScene = load("res://Scenes/main_menu.tscn")

# TODO: Last Step: Make sure that the game handles Losing as well.

func _ready():
	if Input.get_connected_joypads().size() != 0:
		$Bottom/MarginContainer/Button.grab_focus()

func _input(event):
	if Input.get_connected_joypads().size() != 0:
		var focused = get_viewport().gui_get_focus_owner()
		if event.is_action_pressed("select"):
			focused.pressed.emit()
	
	if event.is_action_pressed("back"):
		get_tree().change_scene_to_packed(menu_scene)

func _on_button_pressed():
	get_tree().change_scene_to_packed(main_game)
