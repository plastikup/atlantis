extends Parallax2D

@export var layer: int
@onready var submarine: CharacterBody2D = $'../../Submarine'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signalHub.switch_scene.connect(only_apply_current_tilemap_layer_collision)
	only_apply_current_tilemap_layer_collision()
	
	print(position)


func only_apply_current_tilemap_layer_collision() -> void:
	%TileMapLayer.set_collision_enabled(layer == PlayerInfo.depthLevel+1)
	offset(PlayerInfo.depthLevel+1 - layer)
	
	
#func offset(layer: ParallaxLayer) -> void:
	#var offset := scroll_offset - layer.position
	#var canvas_scale = get_viewport().canvas_transform.get_scale()
	#offset /= canvas_scale.dot(Vector2(0.5, 0.5))
	#layer.motion_offset = offset



func offset(delta_z_index: int):
	# Get the camera's current center position in world coordinates
	# This ensures the alignment happens exactly where the player is looking
	var cam_pos = submarine.get_child(1).get_screen_center_position()

	var new_scale = Vector2(delta_z_index*0.1+1, delta_z_index*0.1+1)
		
	# Calculate the compensation offset
	# Formula: NewOffset = OldOffset + CameraPos * (OldScale - NewScale)
	#var scale_diff = scroll_scale - new_scale
	#var compensation = cam_pos * scale_diff
	scroll_offset = (cam_pos * scroll_scale + scroll_offset) - cam_pos
	
	#scroll_offset = scroll_offset + compensation
	scroll_scale = new_scale
