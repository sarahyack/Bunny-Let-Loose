extends Area2D

signal update_shrooms()

# Main Functions

func _ready():
	var ui = get_tree().get_first_node_in_group("ui")
	update_shrooms.connect(ui.update_shrooms)

# Signal Functions

func _on_body_entered(_body):
	update_shrooms.emit()
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	$CollisionShape2D.set_deferred("disabled", true)
	await $AudioStreamPlayer2D.finished
	queue_free()
