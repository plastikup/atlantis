extends Node


signal ship_upgraded
signal fishing_spot_br
signal fish_some_fish
signal found_clue
signal access_shop
signal hide_shop
signal switch_scene
signal ship_repaired
signal ship_died
signal sonar_upgrade
signal speed_upgrade

func build_request(level) -> void:
	fishing_spot_br.emit(level)
	
func fish_some_fish_request(level) -> void:
	fish_some_fish.emit(level)
	
func ship_upgraded_request() -> void:
	ship_upgraded.emit()
func found_clue_rq() -> void:
	print("found clue")
	found_clue.emit()
	
func open_shop() -> void:
	access_shop.emit()
	
func close_shop() -> void:
	hide_shop.emit()
	
func ship_repaired_request() -> void:
	ship_repaired.emit()
	
func ship_died_request() -> void:
	ship_died.emit()
	
func emit_sonar_upgrade() -> void:
	sonar_upgrade.emit()
	
func emit_speed_upgrade() -> void:
	speed_upgrade.emit()
