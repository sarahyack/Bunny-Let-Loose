extends CharacterBody2D

@export var speed := 200
var direction_x := 0.0

func _process(delta):
	direction_x = Input.get_axis("left", "right")
