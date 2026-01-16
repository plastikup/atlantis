extends Node2D

@export var health := 0

#const COLORS := [Color.DARK_GREEN, Color.GREEN_YELLOW, Color.YELLOW, Color.ORANGE, Color.RED]
#const COLORS := [Color.DARK_GREEN, Color.GREEN_YELLOW, Color.TRANSPARENT, Color.TRANSPARENT, Color.TRANSPARENT]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#%dial.set_new_color_range(COLORS.map(func (color):
		#var i = COLORS.find(color)
		#return {
			#'angle_from': remap(i, 0, COLORS.size(), %dial.EDGE_START_ANGLE * 1.5, %dial.EDGE_END_ANGLE * 1.05) + PI, 
			#'angle_to': %dial.EDGE_END_ANGLE * 1.05 + PI,
			#'color': color,
		#}
	#))
	
	####################
	
	signalHub.ship_upgraded.connect(on_ship_upgraded)
	signalHub.ship_repaired.connect(on_ship_upgraded)
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	PlayerInfo.shipHealth -= PlayerInfo.dps_depth[PlayerInfo.depthLevel]*delta
	#print([PlayerInfo.shipHealth, PlayerInfo.depthLevel])
	setCurrentHealthIndicator(health)

func start_game() -> void:
	var currentLevel = PlayerInfo.player_upgrade_levels[PlayerInfo.upgrade_types.SHIP_MATERIAL]
	var maxHealth = PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][currentLevel]
	setCurrentMaxHealthIndicator(maxHealth)
	PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][4]


func on_life_updated(newValue: int):
	setCurrentHealthIndicator(newValue)
	
func on_ship_upgraded():
	var currentLevel = PlayerInfo.player_upgrade_levels[PlayerInfo.upgrade_types.SHIP_MATERIAL]
	var maxHealth = PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][currentLevel]
	setCurrentMaxHealthIndicator(maxHealth)
	setCurrentHealthIndicator(maxHealth)

func setCurrentMaxHealthIndicator(currentMaxHealth):
	var maxHealthNeedleAngle = remap(currentMaxHealth, 0, PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][4], $dial.maxAngle, $dial.minAngle)
	$dial.set_new_color_range([{
		'angle_from': $dial.minAngle,
		'angle_to': $dial.maxAngle,
		'color': Color.RED,
	}, {
		'angle_from': maxHealthNeedleAngle,
		'angle_to': $dial.maxAngle,
		'color': Color.GREEN,
	}])

func setCurrentHealthIndicator(health):
	$dial.set_needle_angle(remap(health, 0, PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.SHIP_MATERIAL][4], 1, 0))
	
