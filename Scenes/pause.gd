extends CanvasLayer

signal resume()

func _on_button_pressed():
	resume.emit()
	

func _on_visibility_changed():
	$Animation.visible = not $Animation.visible
	$Buttons.visible = not $Buttons.visible
