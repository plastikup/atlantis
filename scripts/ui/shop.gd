extends TextureRect

@onready var upgrade_popup:= $MarginContainer/UpgradePopup
@onready var upgrade_btn := $VBoxContainer/MarginContainer2/VBoxContainer/CenterContainer/Upgrade

@onready var upgrade_name := $VBoxContainer/MarginContainer2/VBoxContainer/Name
@onready var upgrade_level := $VBoxContainer/MarginContainer2/VBoxContainer/Level
@onready var upgrade_description := $VBoxContainer/MarginContainer2/VBoxContainer/Description


var upgrade_costs = {
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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_btn.mouse_entered.connect(upgrade_hover_enter)
	upgrade_btn.mouse_exited.connect(upgrade_hover_exit) # Replace with function body.
	
	currentPageID = 0
	_load_page()

func _load_page() -> void:
	var upgradeType = PlayerInfo.upgrade_types.find_key(currentPageID)
	var currentLevel = PlayerInfo.player_upgrade_levels[int(upgradeType)]
	upgrade_name.text = upgrade_names[int(upgradeType)]
	upgrade_level.text = "LEVEL %s" % (currentLevel + 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func upgrade_hover_enter() -> void:
	upgrade_popup.fade_in()
	
func upgrade_hover_exit() -> void:
	upgrade_popup.fade_out()
