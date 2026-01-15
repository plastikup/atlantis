extends Node

const GAME_WRAPPER = preload("uid://dbbvrvjjexwuv")
const LANDING = preload("res://scenes/landing.tscn")

signal game
signal main_menu

func _ready() -> void:
	main_menu.connect(load_landing)
	game.connect(load_game_wrapper)

func load_game_wrapper() -> void:
	get_tree().change_scene_to_packed(GAME_WRAPPER)

func load_landing() -> void:
	get_tree().change_scene_to_packed(LANDING)
