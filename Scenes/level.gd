extends Node2D

const bullet_scene: PackedScene = preload("res://Scenes/bullet.tscn")
const game_over: PackedScene = preload("res://Scenes/game_over.tscn")

func _ready():
	get_tree().get_first_node_in_group("pause").visible = false

func _input(event):
	if event.is_action_pressed("back"):
		get_tree().paused = true
		get_tree().get_first_node_in_group("pause").show()

func _on_player_shoot(pos, facing_right):
	var bullet = bullet_scene.instantiate()
	var direction = 1 if facing_right else -1
	bullet.position = pos + Vector2(5 * direction, 0)
	bullet.direction = direction
	$Bullets.add_child(bullet)

func _on_ui_won():
	get_tree().change_scene_to_packed(game_over)


func _on_pause_resume():
	get_tree().get_first_node_in_group("pause").hide()
	get_tree().paused = false
