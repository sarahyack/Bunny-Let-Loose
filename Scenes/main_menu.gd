extends Node

const main_game: PackedScene = preload("res://Scenes/game.tscn")

func _ready():
	# Change Panel Label Texts for Controls
	pass

func _on_button_pressed():
	get_tree().change_scene_to_packed(main_game)
