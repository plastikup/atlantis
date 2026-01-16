extends TextureRect

@onready var upgrade_popup:= $MarginContainer/UpgradePopup
@onready var upgrade_btn := $VBoxContainer/MarginContainer2/VBoxContainer/CenterContainer/Upgrade

@onready var upgrade_name := $VBoxContainer/MarginContainer2/VBoxContainer/Name
@onready var upgrade_level := $VBoxContainer/MarginContainer2/VBoxContainer/Level
@onready var upgrade_description := $VBoxContainer/MarginContainer2/VBoxContainer/Description

@onready var left_arrow = $VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/Left
@onready var right_arrow = $VBoxContainer/MarginContainer2/HBoxContainer/MarginContainer/Right

var upgrade_costs := {
	PlayerInfo.upgrade_types.SHIP_MATERIAL: {
		1: [[PlayerInfo.typeLevels.wood, 25]],
		2: [[PlayerInfo.typeLevels.wood, 50], [PlayerInfo.typeLevels.copper, 25]],
		3: [[PlayerInfo.typeLevels.wood, 100], [PlayerInfo.typeLevels.copper, 50], [PlayerInfo.typeLevels.silver, 25]],
		4: [[PlayerInfo.typeLevels.wood, 200], [PlayerInfo.typeLevels.copper, 100], [PlayerInfo.typeLevels.silver, 50], [PlayerInfo.typeLevels.gold, 25]],		
	},
	PlayerInfo.upgrade_types.SPEED: {
		1: [[PlayerInfo.typeLevels.wood, 15]],
		2: [[PlayerInfo.typeLevels.wood, 30], [PlayerInfo.typeLevels.copper, 15]],
		3: [[PlayerInfo.typeLevels.wood, 60], [PlayerInfo.typeLevels.copper, 30], [PlayerInfo.typeLevels.silver, 15]],
		4: [[PlayerInfo.typeLevels.wood, 120], [PlayerInfo.typeLevels.copper, 60], [PlayerInfo.typeLevels.silver, 30], [PlayerInfo.typeLevels.gold, 15]],		
	},
	PlayerInfo.upgrade_types.SONAR: {
		1: [[PlayerInfo.typeLevels.wood, 125]]
	}
}

const upgrade_names := {
	PlayerInfo.upgrade_types.SHIP_MATERIAL: "MATÉRIAU DU VAISSEAU",
	PlayerInfo.upgrade_types.SPEED: "VITESSE DU VAISSEAU",
	PlayerInfo.upgrade_types.SONAR: "SONAR",
}

#TODO implémenter petit bouton i
const upgrade_explanations := {
	PlayerInfo.upgrade_types.SHIP_MATERIAL: "AMÉLIORE LA DURABILITÉ DU VAISSEAU, QUI PEUT RÉSISTER À PLUS DE PRESSION",
	PlayerInfo.upgrade_types.SPEED: "AMÉLIORE LA VITESSE DE DÉPLACEMENT DU VAISSEAU DANS L'EAU",
	PlayerInfo.upgrade_types.SONAR: "DÉBLOQUE UN SONAR QUI PERMET DE LOCALISER LES ÉLÉMENTS IMPORTANTS DU NIVEAU COURANT"
}

const upgrade_level_descriptions := {
	PlayerInfo.upgrade_types.SHIP_MATERIAL: {
		0: "VAISSEAU EN CUIR (%s HP)",
		1: "VAISSEAU EN BOIS (%s HP)",
		2: "VAISSEAU EN CUIVRE (%s HP)",
		3: "VAISSEAU EN ARGENT (%s HP)",
		4: "VAISSEAU EN OR (%s HP)",
	},
	PlayerInfo.upgrade_types.SPEED: {
		0: "VITESSE DE BASE",
		1: "AUGMENTATION DE %s%%",
		2: "AUGMENTATION DE %s%%",
		3: "AUGMENTATION DE %s%%",
		4: "AUGMENTATION DE %s%%",
	},
	PlayerInfo.upgrade_types.SONAR: {
		0: "NON FONCTIONNEL",
		1: "ACTIVÉ"
	}
}

var currentPageID: int = 0
var currentIsMaxed := false

var fontActiveColor := Color.from_rgba8(255, 255, 255, 255)
var fontImpossibleColor := Color.from_rgba8(70, 70, 70, 255)
var fontMaxColor := Color.from_rgba8(250, 211, 0, 255)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_btn.mouse_entered.connect(upgrade_hover_enter)
	upgrade_btn.mouse_exited.connect(upgrade_hover_exit) # Replace with function body.
	upgrade_btn.pressed.connect(upgrade_btn_pressed)
	right_arrow.pressed.connect(arrow_pressed.bind(true))
	left_arrow.pressed.connect(arrow_pressed.bind(false))
	
	currentPageID = 0
	currentIsMaxed = false

func _load_page() -> void:
	currentIsMaxed = false
	upgrade_name.text = upgrade_names[currentPageID]
	var currentLevel = PlayerInfo.player_upgrade_levels[currentPageID]
	if currentPageID == PlayerInfo.upgrade_types.SONAR:
		if currentLevel == 0:
			upgrade_level.text = "TECHNOLOGIE TROP AVANCÉE"
		else:
			upgrade_level.text = "RECHERCHE EFFECTUÉE"
	else:
		upgrade_level.text = "NIVEAU %s" % (currentLevel + 1)
	var description = upgrade_level_descriptions[currentPageID][currentLevel]
	if description.contains("%s"):
		description = description % PlayerInfo.upgrade_level_values[currentPageID][currentLevel]
	upgrade_description.text = description
	
	var btnText = upgrade_btn.get_node("Label")
	if currentLevel + 1 == len(PlayerInfo.upgrade_level_values[currentPageID]):
		btnText.text = "NIVEAU MAX"
		btnText.add_theme_color_override("font_color", fontMaxColor)
		upgrade_btn.disabled = true
		upgrade_popup.fade_out()
		currentIsMaxed = true
	else:
		btnText.text = "AMÉLIORER"
		upgrade_popup.set_cost_infos(upgrade_costs[currentPageID][currentLevel + 1])
		
		if not BuyUtils.isUpgradePossible(upgrade_costs[currentPageID][currentLevel + 1]):
			btnText.add_theme_color_override("font_color", fontImpossibleColor)
			upgrade_btn.disabled = true
		else:
			btnText.add_theme_color_override("font_color", fontActiveColor)
			upgrade_btn.disabled = false
		

func arrow_pressed(right: bool) -> void:
	if right:
		currentPageID = (currentPageID + 1) % len(upgrade_names)
	else: 
		currentPageID -= 1
		if currentPageID < 0:
			currentPageID = len(upgrade_names) - 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_load_page()

func upgrade_hover_enter() -> void:
	if currentIsMaxed:
		return
	upgrade_popup.fade_in()
	
func upgrade_hover_exit() -> void:
	if currentIsMaxed:
		return
	upgrade_popup.fade_out()

func upgrade_btn_pressed() -> void: 
	var currentLevel = PlayerInfo.player_upgrade_levels[currentPageID]
	if BuyUtils.isUpgradePossible(upgrade_costs[currentPageID][currentLevel + 1]):
		BuyUtils.buyUpgrade(upgrade_costs[currentPageID][currentLevel + 1])
		PlayerInfo.player_upgrade_levels[currentPageID] += 1
		if currentPageID == PlayerInfo.upgrade_types.SHIP_MATERIAL:
			signalHub.ship_upgraded_request()
		if currentPageID == PlayerInfo.upgrade_types.SONAR:
			print("sonar")
			signalHub.emit_sonar_upgrade()
		if currentPageID == PlayerInfo.upgrade_types.SPEED:
			signalHub.emit_speed_upgrade()
