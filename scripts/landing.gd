extends Control

var paths := {
	#"play": "res://scenes/start_menu.tscn",
	#"tutorial": "res://scenes/shop.tscn",
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
func _on_button_pressed(go_to: String):
	print(go_to)
	if go_to in paths:
		get_tree().change_scene_to_file(paths[go_to])
		
	
func _on_quit_button_pressed():
	get_tree().quit()
