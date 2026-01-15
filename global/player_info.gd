extends Node

var depthLevel := 0
var radarElements := []
enum typeLevels {leather, wood, copper, silver, gold }


const level_to_name = {typeLevels.leather: 'leather', typeLevels.wood: 'wood', typeLevels.copper: 'copper', typeLevels.silver: 'silver', typeLevels.gold: 'gold' }
var ship_level := typeLevels.leather

enum upgrade_types {
	SHIP_MATERIAL,
	SPEED,
	SONAR,
}

var upgrade_costs = {

}

var player_upgrade_levels = {
	upgrade_types.SHIP_MATERIAL: 0,
	upgrade_types.SPEED: 0,
	upgrade_types.SONAR: 0
}


var fish_inv := {typeLevels.wood: 0, typeLevels.copper: 0, typeLevels.silver: 0, typeLevels.gold: 0 }
