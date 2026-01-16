extends Node

var depthLevel := 0
var playerNode
var radarElements := []
enum typeLevels {leather, wood, copper, silver, gold }

const level_to_name = {typeLevels.leather: 'leather', typeLevels.wood: 'wooden', typeLevels.copper: 'copper', typeLevels.silver: 'silver', typeLevels.gold: 'gold' }

enum upgrade_types {
	SHIP_MATERIAL,
	SPEED,
	SONAR,
	AUTO_FISHING_SPEED
}

const upgrade_level_values := {
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
	},
	upgrade_types.SONAR: {
		0: 0,
		1: 1
	},
	upgrade_types.AUTO_FISHING_SPEED: {
		0: 1,
		1: 3,
		2: 5,
		3: 10,
		4: 15
	}
}

var player_upgrade_levels := {
	upgrade_types.SHIP_MATERIAL: 0,
	upgrade_types.SPEED: 0,
	upgrade_types.SONAR: 0,
	upgrade_types.AUTO_FISHING_SPEED: 0
}

var shipHealth = upgrade_level_values[upgrade_types.SHIP_MATERIAL][0]

const dps_depth := {
	0 : 0,
	1: 2.5,
	2: 5,
	3: 10,
	4: 20
}


var fish_inv := [250,0,0,0]
var clues_found := [0,0,0,0]
