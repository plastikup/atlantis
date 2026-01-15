extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	# tests
	#if Input.is_action_just_pressed("ui_up"):
		#fade_in()
	#elif Input.is_action_just_pressed("ui_down"):
		#fade_out()

func fade_in() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	
func fade_out() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
