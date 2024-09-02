extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1, 1), 0.1).from(Vector2(0, 0))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 200 * delta


func _on_destroy_timer_timeout():
	queue_free()
