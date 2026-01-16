extends CanvasLayer


func _ready() -> void:
	signalHub.switch_scene.connect(blackout_fade)
	signalHub.ship_died.connect(warning_fade)


func reset_to_initial() -> void:
	%ColorRect.modulate.a = 0
	%deathOverlay.modulate.a = 0


func blackout_fade() -> void:
	reset_to_initial()
	%ColorRect.color = Color.BLACK
	%deathOverlay.visible = false

	var tween : Tween = create_tween()
	tween.tween_property(%ColorRect, "modulate:a", 1, 1)
	tween.tween_property(%ColorRect, "modulate:a", 0, 1)

func warning_fade() -> void:
	reset_to_initial()
	%ColorRect.color = Color.DARK_ORANGE
	%deathOverlay.visible = true
	
	var tween := create_tween().set_parallel(true)
	tween.tween_property(%ColorRect, "modulate:a", 1, 1)
	tween.tween_property(%deathOverlay, "modulate:a", 1, 1)
	
	await tween.finished
	await get_tree().create_timer(2.5).timeout
	PlayerInfo.depthLevel = 0
	signalHub.reload_scene.emit()
	await get_tree().create_timer(2.5).timeout
	
	tween = create_tween().set_parallel(true)
	tween.tween_property(%ColorRect, "modulate:a", 0, 1)
	tween.tween_property(%deathOverlay, "modulate:a", 0, 1)
