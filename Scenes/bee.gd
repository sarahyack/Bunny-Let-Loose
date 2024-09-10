extends Area2D

@export var marker1: Marker2D
@export var marker2: Marker2D
@export var speed := 25
@export var speed_boost := 10
@export var health := 3
@export var attack_strength := 1

@onready var target = marker2
@onready var player = get_tree().get_first_node_in_group("player")

var forward := true
var normal := true
var aggressive := false

# Main Functions

func _ready():
	position = marker1.position

func _process(delta):
	check_death()
	get_target()
	flip_logic()
	
	position += (target.position - position).normalized() * speed * delta


# Movement Functions

func get_target():
	if forward and position.distance_to(marker2.position) < 10 or\
		not forward and position.distance_to(marker1.position) < 10:
		forward = not forward
	
	if aggressive:
		target = player
	elif forward:
		target = marker2
	else:
		target = marker1


# Status Functions

func check_death():
	if health <= 0:
		await $AudioStreamPlayer2D.finished
		queue_free()

func flip_logic():
	$Sprite2D.flip_h = not forward
	if aggressive:
		$Sprite2D.flip_h = position.x > player.position.x

func go_aggressive():
	aggressive = true
	if aggressive:
		speed += speed_boost

func reset_aggressive():
	aggressive = false
	if normal:
		speed -= speed_boost

# Signal Functions

func _on_area_entered(area):
	health -= 1
	area.queue_free()
	var tween = create_tween()
	tween.tween_property($Sprite2D, "material:shader_parameter/amount", 1.0, 0.0)
	tween.tween_property($Sprite2D, "material:shader_parameter/amount", 0.0, 0.1).set_delay(0.2)
	$AudioStreamPlayer2D.play()

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.damage(attack_strength)

func _on_detection_range_body_entered(_body):
	go_aggressive()

func _on_detection_range_body_exited(_body):
	reset_aggressive()


# Timeout Functions
