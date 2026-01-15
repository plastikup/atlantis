extends Node

const GAME_WRAPPER = preload("res://scenes/world/game_wrapper.tscn")
const LANDING = preload("res://scenes/landing.tscn")

func load_game_wrapper() -> void:
	get_tree().change_scene_to_packed(GAME_WRAPPER)

func load_landing() -> void:
	get_tree().change_scene_to_packed(LANDING)
