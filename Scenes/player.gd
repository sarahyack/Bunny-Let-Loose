extends CharacterBody2D

@export var speed := 200
@export var health := 5

var direction_x := 0.0
var facing_right := true
var has_gun := false
var can_shoot := false
var can_be_hurt := true

signal shoot(pos: Vector2, direction: bool)


# Main Functions

func _process(_delta):
	get_input()
	apply_gravity()
	get_facing_direction()
	get_animation()
	
	velocity.x = direction_x * speed
	move_and_slide()
	check_death()


# Movement Functions

func get_input():	
	direction_x = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -300
		$Sounds/JumpSound.play()
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot.emit(global_position, facing_right)
		can_shoot = false
		$Timers/ShootTimer.start()
		$Timers/FireTimer.start()
		$Fire.get_child(facing_right).show()
		$Sounds/FireSound.play()

func apply_gravity():
	velocity.y += 20

func get_facing_direction():
	if direction_x != 0:
		facing_right = direction_x >= 0

func get_animation():
	var current_animation = 'idle'
	
	if not is_on_floor():
		current_animation = 'jump'
	elif direction_x != 0:
		current_animation = 'walk'
	if has_gun:
		current_animation += "_gun"
	$Sprites.animation = current_animation
	$Sprites.flip_h = not facing_right


# Status Functions

func damage(amount):
	if can_be_hurt:
		if health > 0:
			health -= amount
		var tween = create_tween()
		tween.tween_property($Sprites, "material:shader_parameter/amount", 1.0, 0.0)
		tween.tween_property($Sprites, "material:shader_parameter/amount", 0.0, 0.1).set_delay(0.2)
		can_be_hurt = false
		$Sounds/HurtSound.play()
		$Timers/HurtTimer.start()

func check_death():
	if health <= 0:
		get_tree().quit()

# Signal Functions


# Timeout Functions

func _on_shoot_timer_timeout():
	if has_gun:
		can_shoot = true

func _on_fire_timer_timeout():
	for child in $Fire.get_children():
		child.hide()

func _on_hurt_timer_timeout():
	can_be_hurt = true
