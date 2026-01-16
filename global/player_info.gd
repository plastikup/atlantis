extends Node

var depthLevel := 0
var playerNode
var radarElements := []
enum typeLevels { leather, wood, copper, silver, gold }

const level_to_name = {typeLevels.leather: 'leather', typeLevels.wood: 'wood', typeLevels.copper: 'copper', typeLevels.silver: 'silver', typeLevels.gold: 'gold' }
var ship_level := typeLevels.leather

enum upgrade_types {
	SHIP_MATERIAL,
	SPEED,
	SONAR,
}

var upgrade_level_values := {
	upgrade_types.SHIP_MATERIAL: {
		0: 25,
		1: 50,
		2: 100,
		3: 200, 
		4: 400
	},
	upgrade_types.SPEED: {
		# in percent of speed added
		0: 0,
		1: 5,
		2: 10,
		3: 25,
		4: 50
	}
}

var player_upgrade_levels := {
	upgrade_types.SHIP_MATERIAL: 0,
	upgrade_types.SPEED: 0,
	upgrade_types.SONAR: 0
}

var shipHealth = upgrade_level_values[upgrade_types.SHIP_MATERIAL][0]


var fish_inv := [0,0,0,0]
var clues_found := [0,0,0,0]
