@tool
extends Node2D

enum ClueTypes { column, egg, trident }
const sprite_agent_scales := {
	ClueTypes.column: 3.0,
	ClueTypes.egg: 1.5,
	ClueTypes.trident: 1.5,
}
const clue_images := {
	ClueTypes.column: preload('res://assets/items/colonne.png'),
	ClueTypes.egg: preload('res://assets/items/oeuf.png'),
	ClueTypes.trident: preload('res://assets/items/trident.png'),
}
const collision_shapes := {
	ClueTypes.column: {
		'radius': 61.0,
		'rotation': 0.0,
	},
	ClueTypes.egg: {
		'radius': 54.0,
		'rotation': 0.0,
	},
	ClueTypes.trident: {
		'radius': 42.0,
		'rotation': 0.0,
	},
}
const progress_bar_y_offset := {
	ClueTypes.column: -2200.0,
	ClueTypes.egg: -1350.0,
	ClueTypes.trident: -1370.0,
}


@export var mode: ClueTypes:
	set(value):
		mode = value
		update_clue_type()
@export var prefer_bottom_text: bool:
	set(value):
		prefer_bottom_text = value
		update_clue_type()

func update_clue_type():
	if not Engine.is_editor_hint(): return
	
	%SpriteAgent.scale = Vector2(sprite_agent_scales[mode], sprite_agent_scales[mode])
	
	%Sprite2D.texture = clue_images[mode]
	
	%CollisionShape2D.shape.radius = collision_shapes[mode].radius
	%CollisionShape2D.rotation = collision_shapes[mode].rotation
	
	%ProgressBar.position.y = progress_bar_y_offset[mode] * (-1 if prefer_bottom_text else 1)
	#if value == ClueTypes.column:
		#%Sprite2D.color = "#00000040"
	#elif value == ClueTypes.egg:
		#%ColorRect.color = "#FFFFFF40"
