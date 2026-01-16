extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signalHub.switch_scene.connect(only_apply_current_tilemap_layer_collision)
	only_apply_current_tilemap_layer_collision()


func only_apply_current_tilemap_layer_collision() -> void:
	await get_tree().create_timer(1.0).timeout

	var self_is_current_tilemap = get_parent().get_meta('level') == PlayerInfo.depthLevel+1
	set_collision_enabled(self_is_current_tilemap)
	get_parent().visible = self_is_current_tilemap
	
