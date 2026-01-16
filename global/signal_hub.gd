extends Node


signal ship_upgraded
signal fishing_spot_br
signal fish_some_fish
signal access_outpost
signal leave_outpost
signal found_clue
signal access_shop
signal hide_shop
signal switch_scene
signal ship_repaired
signal ship_died # only used for ui
signal reload_scene # used by game after ui loads (there's a delay between the two)
signal sonar_upgrade
signal speed_upgrade
signal menu
signal menu_hidden
signal in_bound_area
signal open_inventory
signal close_inventory

func open_inventory_request() -> void:
	open_inventory.emit()
	
func close_inventory_request() -> void:
	close_inventory.emit()


func area_entered(area) -> void:
	in_bound_area.emit(area)
	
func build_request(level) -> void:
	fishing_spot_br.emit(level)
	
func open_outpost(level) -> void:
	access_outpost.emit(level)
	
func exit_outpost() -> void:
	leave_outpost.emit()
	
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
	
func menu_popup() -> void:
	print("open")
	menu.emit()

func menu_hide() -> void:
	menu_hidden.emit()
