extends CanvasLayer

signal resume()

func _input(event):
	if Input.get_connected_joypads().size() != 0:
		var focused = get_viewport().gui_get_focus_owner()
		if event.is_action_pressed("select"):
			focused.pressed.emit()
		elif event.is_action_pressed("back"):
			focused.pressed.emit()

func _on_button_pressed():
	resume.emit()

func _on_visibility_changed():
	$Animation.visible = not $Animation.visible
	$Buttons.visible = not $Buttons.visible

func _on_level_paused():
	if Input.get_connected_joypads().size() != 0:
		$Buttons/MarginContainer/Button.grab_focus()
