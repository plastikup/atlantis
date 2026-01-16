extends StaticBody2D

var level := 0 # will be initialized by level

const ACTION:= "interact"
var is_inbound := false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	is_inbound = true

func _on_body_exited(body: Node2D) -> void:
	is_inbound = false



func _on_timer_timeout() -> void:
	var upgradeLevel = PlayerInfo.outpost_upgrade_levels[level]
	var generatedFish = PlayerInfo.upgrade_level_values[PlayerInfo.upgrade_types.AUTO_FISHING_SPEED][upgradeLevel]
	PlayerInfo.fish_inv[level] += generatedFish
	print(generatedFish, " of level ", level)
	print(position)
