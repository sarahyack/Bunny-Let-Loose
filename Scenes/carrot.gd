extends Area2D

signal update_carrot()

# Main Functions

func _process(delta):
	position.y += sin(Time.get_ticks_msec() / 200.0) * 10 * delta

# Signal Functions

func _on_body_entered(_body):
	update_carrot.emit()
	$AudioStreamPlayer2D.play()
	$Sprite2D.hide()
	await $AudioStreamPlayer2D.finished
	queue_free()
