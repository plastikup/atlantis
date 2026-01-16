extends Control
@onready var upgrade_btn := $"image bois/upgrade button"
@onready var upgrade_popup := $"image bois/CostPopup"
@onready var upgrade_vitesse_actuelle := $"image bois/stats/couts upgrade/p4/info_vitesse"
var currentLevel = PlayerInfo.player_upgrade_levels[3]
var currentIsMaxed = false
var fontActiveColor := Color.from_rgba8(255, 255, 255, 255)
var fontImpossibleColor := Color.from_rgba8(70, 70, 70, 255)
var fontMaxColor := Color.from_rgba8(250, 211, 0, 255)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_btn.mouse_entered.connect(upgrade_hover_enter)
	upgrade_btn.mouse_exited.connect(upgrade_hover_exit)
	upgrade_btn.pressed.connect(upgrade_btn_pressed)

var upgrade_costs := {
	PlayerInfo.upgrade_types.AUTO_FISHING_SPEED: {
		1: [[PlayerInfo.typeLevels.wood, 20]],
		2: [[PlayerInfo.typeLevels.wood, 40], [PlayerInfo.typeLevels.copper, 20]],
		3: [[PlayerInfo.typeLevels.wood, 80], [PlayerInfo.typeLevels.copper, 40], [PlayerInfo.typeLevels.silver, 20]],
		4: [[PlayerInfo.typeLevels.wood, 160], [PlayerInfo.typeLevels.copper, 80], [PlayerInfo.typeLevels.silver, 40], [PlayerInfo.typeLevels.gold, 20]]}		
	}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_load_page()

func upgrade_hover_enter() -> void:
	upgrade_popup.fade_in()
	
func upgrade_hover_exit() -> void:
	upgrade_popup.fade_out()
	
func _load_page() -> void:
	currentIsMaxed = false
	upgrade_vitesse_actuelle.text = "%d poissons par seconde" % PlayerInfo.upgrade_level_values[3][currentLevel]
	currentLevel = PlayerInfo.player_upgrade_levels[3]
	
	if currentLevel + 1 == len(PlayerInfo.upgrade_level_values[3]):
		upgrade_btn.text = "NIVEAU MAX"
		upgrade_btn.add_theme_color_override("font_color", fontMaxColor)
		upgrade_btn.disabled = true
		upgrade_popup.fade_out()
		currentIsMaxed = true
	else:
		upgrade_btn.text = "AMÉLIORER"
		upgrade_popup.set_cost_infos(upgrade_costs[3][currentLevel + 1])
		
		if not BuyUtils.isUpgradePossible(upgrade_costs[3][currentLevel + 1]):
			upgrade_btn.add_theme_color_override("font_color", fontImpossibleColor)
			upgrade_btn.disabled = true
		else:
			upgrade_btn.add_theme_color_override("font_color", fontActiveColor)
			upgrade_btn.disabled = false
			
func upgrade_btn_pressed() -> void: 
	currentLevel = PlayerInfo.player_upgrade_levels[3]
	if BuyUtils.isUpgradePossible(upgrade_costs[3][currentLevel + 1]):
		BuyUtils.buyUpgrade(upgrade_costs[3][currentLevel + 1])
		PlayerInfo.player_upgrade_levels[3] += 1
		if 3 == PlayerInfo.upgrade_types.SHIP_MATERIAL:
			print("ship")
			signalHub.ship_upgraded_request()
