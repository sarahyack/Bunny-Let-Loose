extends Area2D

signal update_shrooms()

# Main Functions

# Signal Functions

func _on_body_entered(_body):
	update_shrooms.emit()
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
