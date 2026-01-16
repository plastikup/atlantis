extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signalHub.switch_scene.connect(only_apply_current_tilemap_layer_collision)
	only_apply_current_tilemap_layer_collision()


func only_apply_current_tilemap_layer_collision() -> void:
	var ship_level = PlayerInfo.player_upgrade_levels[PlayerInfo.upgrade_types.SHIP_MATERIAL]
	print('unsmily face', get_parent().get_meta('level'), ship_level+1, get_parent().get_meta('level') == ship_level+1)
	set_collision_enabled(get_parent().get_meta('level') == ship_level+1)
