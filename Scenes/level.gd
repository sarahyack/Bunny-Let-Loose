extends Node2D

const bullet_scene: PackedScene = preload("res://Scenes/bullet.tscn")

func _on_player_shoot(pos):
	var bullet = bullet_scene.instantiate()
	bullet.position = pos
	$Bullets.add_child(bullet)
