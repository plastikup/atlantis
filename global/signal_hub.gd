extends Node


signal ship_upgraded
signal fishing_spot_br
signal fish_some_fish

func build_request(level) -> void:
	fishing_spot_br.emit(level)
	
func fish_some_fish_request(level) -> void:
	fish_some_fish.emit(level)
	
func ship_upgraded_request() -> void:
	print("wow")
	ship_upgraded.emit()
