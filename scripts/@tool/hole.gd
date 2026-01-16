@tool
extends Node2D

enum HoleTypes { to_bottom, to_surface }
@export var mode: HoleTypes:
	set(value):
		mode = value
		update_hole_type(value)

func update_hole_type(value: HoleTypes):
	if not Engine.is_editor_hint(): return
	if value == HoleTypes.to_bottom:
		%ColorRect.color = "#00000040"
	elif value == HoleTypes.to_surface:
		%ColorRect.color = "#FFFFFF40"


@export var layer: int
