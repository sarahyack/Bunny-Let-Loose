extends Node2D

const bullet_scene: PackedScene = preload("res://Scenes/bullet.tscn")
const game_over: PackedScene = preload("res://Scenes/game_over.tscn")

signal paused()

func _ready():
	get_tree().get_first_node_in_group("pause").visible = false
	$Player.dead.connect(get_tree().get_first_node_in_group("ui").on_player_dead)

func _input(event):
	if event.is_action_pressed("back"):
		get_tree().paused = true
		get_tree().get_first_node_in_group("pause").show()
		paused.emit()
		set_process_input(false)

func load_end_game(win_status):
	var game_over_instance = game_over.instantiate()
	game_over_instance.won = win_status
	get_tree().root.add_child(game_over_instance)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = game_over_instance

func _on_player_shoot(pos, facing_right):
	var bullet = bullet_scene.instantiate()
	var direction = 1 if facing_right else -1
	bullet.position = pos + Vector2(5 * direction, 0)
	bullet.direction = direction
	$Bullets.add_child(bullet)

func _on_pause_resume():
	get_tree().get_first_node_in_group("pause").hide()
	get_tree().paused = false
	set_process_input(true)


func _on_ui_won():
	load_end_game(true)

func _on_ui_lost():
	load_end_game(false)
