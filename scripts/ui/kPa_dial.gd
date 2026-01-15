extends Node2D

const COLORS := [Color.DARK_GREEN, Color.GREEN_YELLOW, Color.YELLOW, Color.ORANGE, Color.RED]
#const COLORS := [Color.DARK_GREEN, Color.GREEN_YELLOW, Color.TRANSPARENT, Color.TRANSPARENT, Color.TRANSPARENT]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%dial.set_new_color_range(COLORS.map(func (color):
		var i = COLORS.find(color)
		return {
			'angle_from': remap(i, 0, COLORS.size(), %dial.EDGE_START_ANGLE * 1.5, %dial.EDGE_END_ANGLE * 1.05) + PI, 
			'angle_to': %dial.EDGE_END_ANGLE * 1.05 + PI,
			'color': color,
		}
	))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
