extends Node2D

enum DialTypes { fishing, pressure }
@export var DIAL_TYPE: DialTypes

const FULL_IMG_TRUE_IMG_RATIO := 3.0/4.0
@export var DIAL_MARGIN := 0.25
@export var DIAL_COLOR := Color.ALICE_BLUE

@export var FISHING_SPEED_DAMPING := 0.4

const ANGLE_RANGE := PI * 0.61

const EDGE_START_ANGLE = PI/2 - ANGLE_RANGE
const EDGE_END_ANGLE = PI/2 + ANGLE_RANGE

var color_ranges := [{
	'angle_from': EDGE_START_ANGLE,
	'angle_to': -EDGE_END_ANGLE,
	'color': Color.WHITE,
}]
#var color_ranges := [{
	#'angle_from': -PI/2 - 0.1,
	#'angle_to': -PI/2 + 0.1,
	#'color': Color.LAWN_GREEN,
#}]


func _process(_delta: float) -> void:
	if DIAL_TYPE == DialTypes.fishing:
		# update the moving needle's angle
		var needle_progress := (sin(Time.get_unix_time_from_system() / FISHING_SPEED_DAMPING))
		set_needle_angle(remap(needle_progress, -1, 1, 0, 1))

## Expects a float between 0 and 1 to represent the needle's progress between a from angle and a to angle
func set_needle_angle(needle_progress: float) -> void:
	%needle.rotation = remap(needle_progress, 0, 1, -1, 1) * ANGLE_RANGE

## Update the color ranges of the dial
func set_new_color_range(new_color_ranges: Array) -> void:
	color_ranges = new_color_ranges
	queue_redraw()


func _draw() -> void:
	var image_center = Vector2(0, -136)
	for color_range in color_ranges:
		draw_filled_arc(Vector2.ZERO, image_center, 650, color_range.angle_from, color_range.angle_to, color_range.color, 32)


func draw_filled_arc(
	decenter: Vector2,
	center: Vector2,
	radius: float,
	angle_from: float,
	angle_to: float,
	color: Color,
	nb_points: int
) -> void:
	var points := PackedVector2Array()
	points.push_back(decenter)
	
	for i in range(nb_points + 1):
		var angle_to_point := (angle_to - angle_from) * i / nb_points + angle_from
		points.push_back(Vector2.from_angle(angle_to_point) * radius + center)
		
	draw_polygon(points, PackedColorArray([color]))
