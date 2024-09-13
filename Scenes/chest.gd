extends Area2D

@onready var carrot_scene: PackedScene = preload("res://Scenes/carrot.tscn")
@onready var ui_node = get_tree().get_first_node_in_group("ui")
var empty := false

# Main Functions

func handle_collision():
	if not empty:
		trigger_open()
		empty = true
	else:
		$AudioStreamPlayer2D.play()

# Status Functions

func trigger_open():
	var carrot = carrot_scene.instantiate()
	carrot.position = position + Vector2(0, -10)
	carrot.update_carrot.connect(ui_node.update_carrots)
	get_tree().current_scene.call_deferred("add_sibling", carrot)

# Signal Functions

func _on_body_entered(_body):
	handle_collision()
