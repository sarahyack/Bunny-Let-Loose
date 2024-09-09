extends Area2D

@export var speed := 50
@export var health := 2
@export var attack_strength := 1

var direction_x := 1

# Main Functions

func _process(delta):
	check_death()
	
	position.x += direction_x * speed * delta

# Movement Functions

# Status Functions

func check_death():
	if health <= 0:
		await $AudioStreamPlayer2D.finished
		queue_free()

func trigger_flip():
	direction_x *= -1
	update_flip()

func update_flip():
	if direction_x == -1:
		$Sprites.flip_h = true
	else:
		$Sprites.flip_h = false

# Signal Functions

func _on_area_entered(area):
	health -= 1
	area.queue_free()
	var tween = create_tween()
	tween.tween_property($Sprites, "material:shader_parameter/amount", 1.0, 0.0)
	tween.tween_property($Sprites, "material:shader_parameter/amount", 0.0, 0.1).set_delay(0.2)
	$AudioStreamPlayer2D.play()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.damage(attack_strength)

func _on_border_area_body_entered(_body):
	trigger_flip()

func _on_cliff_detect_body_exited(_body):
	trigger_flip()


# Timeout Functions
