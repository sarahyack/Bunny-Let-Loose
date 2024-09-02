extends CharacterBody2D

@export var speed := 200
var direction_x := 0.0
var facing_right := true
var has_gun := true
var can_shoot := true

signal shoot(pos: Vector2)

func _process(_delta):
	# print(Input.get_axis("left", "right"))
	get_input()
	apply_gravity()
	get_facing_direction()
	get_animation()
	
	velocity.x = direction_x * speed
	move_and_slide()

func get_input():
	direction_x = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -300
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot.emit(global_position)
		can_shoot = false
		$Timers/ShootTimer.start()

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

func _on_shoot_timer_timeout():
	can_shoot = true
