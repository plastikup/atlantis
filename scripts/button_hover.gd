extends Button

@export var tween_intensity: float = 1.1
@export var tween_duration: float = 0.1


func _ready():
	pivot_offset = size / 2
	connect("mouse_entered", btn_hovered.bind(true))
	connect("mouse_exited", btn_hovered.bind(false))
	connect("button_down", btn_hovered.bind(false, true))


func btn_hovered(enter: bool, trigger_rise: bool = false):
	var tween := create_tween()
	if disabled:
		tween.tween_property(self, "scale", Vector2.ONE, tween_duration)
		return
	if enter:
		tween.tween_property(self, "scale", Vector2.ONE * tween_intensity, tween_duration)
	else:
		tween.tween_property(self, "scale", Vector2.ONE, tween_duration)

	if trigger_rise:
		tween.finished.connect(btn_hovered.bind(true))
