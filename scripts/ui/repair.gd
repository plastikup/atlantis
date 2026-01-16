extends TextureRect


@onready var repair_popup:=$MarginContainer/RepairPopup
@onready var repair_btn: Button = $VBoxContainer/MarginContainer2/VBoxContainer/CenterContainer/Repair

var repair_costs := {
		0: [[PlayerInfo.typeLevels.wood, 10]],
		1: [[PlayerInfo.typeLevels.wood, 20], [PlayerInfo.typeLevels.copper, 10]],
		2: [[PlayerInfo.typeLevels.wood, 40], [PlayerInfo.typeLevels.copper, 20], [PlayerInfo.typeLevels.silver, 10]],
		3: [[PlayerInfo.typeLevels.wood, 80], [PlayerInfo.typeLevels.copper, 40], [PlayerInfo.typeLevels.silver, 20], [PlayerInfo.typeLevels.gold, 10]],
		4: [[PlayerInfo.typeLevels.wood, 200], [PlayerInfo.typeLevels.copper, 100], [PlayerInfo.typeLevels.silver, 50], [PlayerInfo.typeLevels.gold, 25]]
	}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	repair_btn.mouse_entered.connect(repair_hover_enter)
	repair_btn.mouse_exited.connect(repair_hover_exit)
	repair_btn.pressed.connect(repair_pressed)

	
func repair_hover_enter() -> void:
	repair_popup.fade_in()
	
func repair_hover_exit() -> void:
	repair_popup.fade_out()

func repair_pressed() -> void:
	var type = PlayerInfo.upgrade_types.SHIP_MATERIAL
	var currentLevel = PlayerInfo.player_upgrade_levels[type]
	if BuyUtils.isUpgradePossible(repair_costs[currentLevel]):
		BuyUtils.buyUpgrade(repair_costs[currentLevel])
		# repair ship
		PlayerInfo.shipHealth = PlayerInfo.upgrade_level_values[type][currentLevel]
	
