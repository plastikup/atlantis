extends Node

const GAME_WRAPPER = preload("uid://dbbvrvjjexwuv")
const LANDING = preload("uid://b2a5nmp8lmi2b")


func load_game_wrapper() -> void:
	get_tree().change_scene_to_packed(GAME_WRAPPER)

func load_landing() -> void:
	get_tree().change_scene_to_packed(LANDING)
