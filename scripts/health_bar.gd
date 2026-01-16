extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	min_value = 0
	signalHub.ship_upgraded.connect(on_ship_upgraded)
	signalHub.ship_repaired.connect(on_ship_upgraded)
	start_game()
	
func start_game() -> void:
	var currentLevel = PlayerInfo.player_upgrade_levels[PlayerInfo.upgrade_types.SHIP_MATERIAL]
	var maxHealth = PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][currentLevel]
	max_value = maxHealth
	value = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_life_updated(newValue: int):
	value = newValue
	
func on_ship_upgraded():
	var currentLevel = PlayerInfo.player_upgrade_levels[PlayerInfo.upgrade_types.SHIP_MATERIAL]
	var maxHealth = PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][currentLevel]
	max_value = maxHealth
	value = maxHealth
