extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

@export var max_carrots: int
@export var max_shrooms: int
var current_carrots := 0
var current_shrooms := 0
var seperator := "/"

signal won()
signal lost()

func _ready():
	$MarginContainer/ProgressBar.max_value = player.health

func _process(_delta):
	$MarginContainer/ProgressBar.value = player.health
	$ItemList/HBoxContainer/Carrots/CarrotNum.text = str(current_carrots) + seperator + str(max_carrots)
	$ItemList/HBoxContainer/Shrooms/ShroomNum.text = str(current_shrooms) + seperator + str(max_shrooms)
	check_if_won()

func update_carrots():
	current_carrots += 1

func update_shrooms():
	current_shrooms += 1

func is_tap_on_button() -> bool:
	var buttons = [$MovementCtrlButtons/LeftButton, $MovementCtrlButtons/RightButton, $Jump/JumpButton, $MenuButtons/QuitButton, $MenuButtons/PauseButton]
	
	for button in buttons:
		if button.is_pressed():
			return true
	
	return false

func check_if_won():
	if current_carrots == max_carrots and current_shrooms == max_shrooms:
		won.emit()

func on_player_dead():
	lost.emit()

func _on_quit_button_pressed():
	get_tree().quit()
