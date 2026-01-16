extends Control

var paths := {
	"play": gameManager.game,
	"tutorial": gameManager.touches
}

@onready var play_button: Button = $TextureRect/CenterContainer/Buttons/Play
@onready var tutorial_button: Button = $TextureRect/CenterContainer/Buttons/Tutorial
@onready var quit_button: Button = $TextureRect/CenterContainer/Buttons/Quit
@onready var bgAnimation: AnimationPlayer = $TextureRect3/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_button.pressed.connect(_on_button_pressed.bind("play"))
	tutorial_button.pressed.connect(_on_button_pressed.bind("tutorial"))
	quit_button.pressed.connect(_on_quit_button_pressed)
	
	bgAnimation.play("bg")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_button_pressed(go_to: String) -> void:
	print(go_to)
	if go_to in paths:
		paths[go_to].emit()
		
	
func _on_quit_button_pressed():
	get_tree().quit()
