extends Area2D

@export var health := 3
@export var attack_strength := 1

# Main Functions

func _process(_delta):
	check_death()

# Movement Functions

# Status Functions

func check_death():
	if health <= 0:
		queue_free()

# Signal Functions

func _on_area_entered(area):
	health -= 1
	area.queue_free()
	var tween = create_tween()
	tween.tween_property($Sprite2D, "material:shader_parameter/amount", 1.0, 0.0)
	tween.tween_property($Sprite2D, "material:shader_parameter/amount", 0.0, 0.2)

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.damage(attack_strength)


# Timeout Functions
