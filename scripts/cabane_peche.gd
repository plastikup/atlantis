extends Control
@onready var upgrade_btn := $"image bois/upgrade button"
@onready var upgrade_popup := $"image bois/CostPopup"
@onready var upgrade_vitesse_actuelle := $"image bois/stats/couts upgrade/p4/info_vitesse"
@onready var fish_img := $TextureRect
var currentIsMaxed = false
var fontActiveColor := Color.from_rgba8(255, 255, 255, 255)
var fontImpossibleColor := Color.from_rgba8(70, 70, 70, 255)
var fontMaxColor := Color.from_rgba8(250, 211, 0, 255)
var outpostID : int = 3

const fishImgs = {
	PlayerInfo.typeLevels.wood: preload("res://assets/fish/wooden.png"),
	PlayerInfo.typeLevels.silver: preload("res://assets/fish/silver.png"),
	PlayerInfo.typeLevels.copper: preload("res://assets/fish/copper.png"),
	PlayerInfo.typeLevels.gold: preload("res://assets/fish/gold.png")
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_btn.mouse_entered.connect(upgrade_hover_enter)
	upgrade_btn.mouse_exited.connect(upgrade_hover_exit)
	upgrade_btn.pressed.connect(upgrade_btn_pressed)
	
	fish_img.texture = fishImgs[outpostID + 1]
	

var upgrade_costs := {
	0: {
		1: [[PlayerInfo.typeLevels.wood, 10]],
		2: [[PlayerInfo.typeLevels.wood, 30]],
		3: [[PlayerInfo.typeLevels.wood, 70]],
	},
	1: {
		1: [[PlayerInfo.typeLevels.copper, 10], [PlayerInfo.typeLevels.wood, 20]],
		2: [[PlayerInfo.typeLevels.copper, 30], [PlayerInfo.typeLevels.wood, 50]],
		3: [[PlayerInfo.typeLevels.copper, 70], [PlayerInfo.typeLevels.wood, 120]],
	}, 
	2: {
		1: [[PlayerInfo.typeLevels.silver, 10], [PlayerInfo.typeLevels.copper, 20], [PlayerInfo.typeLevels.wood, 40]],
		2: [[PlayerInfo.typeLevels.silver, 30], [PlayerInfo.typeLevels.copper, 50], [PlayerInfo.typeLevels.wood, 80]],
		3: [[PlayerInfo.typeLevels.silver, 70], [PlayerInfo.typeLevels.copper, 120], [PlayerInfo.typeLevels.wood, 180]],
	},
	3: {
		1: [[PlayerInfo.typeLevels.gold, 10], [PlayerInfo.typeLevels.silver, 20], [PlayerInfo.typeLevels.copper, 40], [PlayerInfo.typeLevels.wood, 80]],
		2: [[PlayerInfo.typeLevels.gold, 30], [PlayerInfo.typeLevels.silver, 50], [PlayerInfo.typeLevels.copper, 80], [PlayerInfo.typeLevels.wood, 120]],
		3: [[PlayerInfo.typeLevels.gold, 70], [PlayerInfo.typeLevels.silver, 120], [PlayerInfo.typeLevels.copper, 180], [PlayerInfo.typeLevels.wood, 250]],
	}
		
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
	var currentLevel = PlayerInfo.outpost_upgrade_levels[outpostID]
	upgrade_vitesse_actuelle.text = "%d poissons par seconde" % PlayerInfo.upgrade_level_values[3][currentLevel]
	
	if currentLevel + 1 == len(PlayerInfo.upgrade_level_values[3]):
		upgrade_btn.text = "NIVEAU MAX"
		upgrade_btn.add_theme_color_override("font_color", fontMaxColor)
		upgrade_btn.disabled = true
		upgrade_popup.fade_out()
		currentIsMaxed = true
	else:
		if currentLevel == 0:
			upgrade_btn.text = "CONSTRUIRE"
		else: 
			upgrade_btn.text = "AMÉLIORER"
		var costs = upgrade_costs[outpostID][currentLevel + 1]
		upgrade_popup.set_cost_infos(costs)
		
		if not BuyUtils.isUpgradePossible(costs):
			upgrade_btn.add_theme_color_override("font_color", fontImpossibleColor)
			upgrade_btn.disabled = true
		else:
			upgrade_btn.add_theme_color_override("font_color", fontActiveColor)
			upgrade_btn.disabled = false
			
func upgrade_btn_pressed() -> void: 
	var currentLevel = PlayerInfo.outpost_upgrade_levels[outpostID]
	var costs = upgrade_costs[outpostID][currentLevel + 1]
	if BuyUtils.isUpgradePossible(costs):
		BuyUtils.buyUpgrade(costs)
		PlayerInfo.outpost_upgrade_levels[outpostID] += 1
