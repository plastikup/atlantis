extends Node

var depthLevel := 0
var radarElements := []
enum ShipLevels { leather, wood, copper, silver, gold }

var ship_level := ShipLevels.leather
const ship_level_to_name = { ShipLevels.leather: 'leather', ShipLevels.wood: 'wood', ShipLevels.copper: 'copper', ShipLevels.silver: 'silver', ShipLevels.gold: 'gold' }
