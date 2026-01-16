extends Node

func isUpgradePossible(costRequirements) -> bool:
	var possible = true
	for requirement in costRequirements:
		var fishType = requirement[0]
		var fishCount = requirement[1]
		if fishCount > PlayerInfo.fish_inv[fishType - 1]:
			possible = false
			break
	return possible
	
	
func buyUpgrade(costRequirements) -> void:
	if not isUpgradePossible(costRequirements):
		print("NOOOO NOT POSSIBLE")
		return
	for requirement in costRequirements:
		var fishType = requirement[0]
		var fishCount = requirement[1]
		PlayerInfo.fish_inv[fishType - 1] -= fishCount
	
	
