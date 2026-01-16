extends ColorRect


func _ready() -> void:
	signalHub.switch_scene.connect(fade_in)


func fade_in() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 1)
	tween.tween_property(self, "modulate:a", 0, 1)
