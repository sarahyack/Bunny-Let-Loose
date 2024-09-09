extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	$MarginContainer/ProgressBar.max_value = player.health

func _process(_delta):
	$MarginContainer/ProgressBar.value = player.health
