extends Node2D

enum ClueTypes { column, egg, trident , shell, plaque, main_cousteau, lumiere, xbox, cousteau, coquillage, collier, billet, assiete}
const sprite_agent_scales := {
	ClueTypes.column: 3.0,
	ClueTypes.egg: 1.5,
	ClueTypes.trident: 1.5,
	ClueTypes.shell: 1.5,
	ClueTypes.plaque: 1.5,
	ClueTypes.main_cousteau: 1.5,
	ClueTypes.lumiere: 1.5,
	ClueTypes.xbox: 1.5,
	ClueTypes.cousteau: 1.5,
	ClueTypes.coquillage: 1.5,
	ClueTypes.collier: 1.5,
	ClueTypes.billet: 1.5,
	ClueTypes.assiete: 1.5,
}
const clue_images := {
	ClueTypes.column: preload('res://assets/items/colonne.png'),
	ClueTypes.egg: preload('res://assets/items/oeuf.png'),
	ClueTypes.trident: preload('res://assets/items/trident.png'),
	ClueTypes.shell: preload('res://assets/items/shell.png'),
	ClueTypes.plaque: preload('res://assets/items/plaque.png'),
	ClueTypes.main_cousteau: preload('res://assets/items/mainCousteau.png'),
	ClueTypes.lumiere: preload('res://assets/items/lumiere.png'),
	ClueTypes.xbox: preload('res://assets/items/xbox.png'),
	ClueTypes.cousteau: preload('res://assets/items/cousteau.png'),
	ClueTypes.coquillage: preload('res://assets/items/coquillage.png'),
	ClueTypes.collier: preload('res://assets/items/collier.png'),
	ClueTypes.billet: preload('res://assets/items/billet.png'),
	ClueTypes.assiete: preload('res://assets/items/assiete.png'),
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
	ClueTypes.shell: {
		'radius': 50.0,
		'rotation': 0.0,
	},
	ClueTypes.plaque: {
		'radius': 55.0,
		'rotation': 0.0,
	},
	ClueTypes.main_cousteau: {
		'radius': 50.0,
		'rotation': 0.0,
	},
	ClueTypes.lumiere: {
		'radius': 45.0,
		'rotation': 0.0,
	},
	ClueTypes.xbox: {
		'radius': 50.0,
		'rotation': 0.0,
	},
	ClueTypes.cousteau: {
		'radius': 50.0,
		'rotation': 0.0,
	},
	ClueTypes.coquillage: {
		'radius': 50.0,
		'rotation': 0.0,
	},
	ClueTypes.collier: {
		'radius': 45.0,
		'rotation': 0.0,
	},
	ClueTypes.billet: {
		'radius': 45.0,
		'rotation': 0.0,
	},
	ClueTypes.assiete: {
		'radius': 50.0,
		'rotation': 0.0,
	},
}
const progress_bar_y_offset := {
	ClueTypes.column: -2200.0,
	ClueTypes.egg: -1350.0,
	ClueTypes.trident: -1370.0,
	ClueTypes.shell: -1350.0,
	ClueTypes.plaque: -1400.0,
	ClueTypes.main_cousteau: -1350.0,
	ClueTypes.lumiere: -1300.0,
	ClueTypes.xbox: -1350.0,
	ClueTypes.cousteau: -1350.0,
	ClueTypes.coquillage: -1350.0,
	ClueTypes.collier: -1300.0,
	ClueTypes.billet: -1300.0,
	ClueTypes.assiete: -1350.0,
}


@export var mode: ClueTypes
@export var prefer_bottom_text: bool

func _ready():	
	%SpriteAgent.scale = Vector2(sprite_agent_scales[mode], sprite_agent_scales[mode])
	
	%Sprite2D.texture = clue_images[mode]
	
	%CollisionShape2D.shape.radius = collision_shapes[mode].radius
	%CollisionShape2D.rotation = collision_shapes[mode].rotation
	
	%ProgressBar.position.y = progress_bar_y_offset[mode] * (-1 if prefer_bottom_text else 1)
	#if value == ClueTypes.column:
		#%Sprite2D.color = "#00000040"
	#elif value == ClueTypes.egg:
		#%ColorRect.color = "#FFFFFF40"
