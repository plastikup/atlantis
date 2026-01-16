extends Node


signal ship_upgraded
signal fishing_spot_br
signal fish_some_fish
signal switch_scene

func build_request(level) -> void:
	fishing_spot_br.emit(level)
	
func fish_some_fish_request(level) -> void:
	fish_some_fish.emit(level)
