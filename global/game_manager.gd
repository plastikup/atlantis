extends Node

const GAME_WRAPPER = preload("res://scenes/world/game_wrapper.tscn")
const LANDING = preload("res://scenes/landing.tscn")
const SELECTION_CONTROLES = preload("res://scenes/ui/selection_controles.tscn")

signal game
signal main_menu
signal touches

func _ready() -> void:
	main_menu.connect(load_landing)
	game.connect(load_game_wrapper)
	touches.connect(load_controles)

func load_game_wrapper() -> void:
	get_tree().change_scene_to_packed(GAME_WRAPPER)

func load_landing() -> void:
	get_tree().change_scene_to_packed(LANDING)
	
func load_controles() -> void:
	get_tree().change_scene_to_packed(SELECTION_CONTROLES)
