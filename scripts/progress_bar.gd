extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	# tests
	#if Input.is_action_just_pressed("ui_accept"):
		#lose_life(5)
	#elif Input.is_action_just_pressed("ui_down"):
		#reload()
	
func lose_life(amount: int) -> void:
	# the bar goes from 100 to 0, use it when theres damage
	value -= amount
	
func reload() -> void:
	# loads it full
	value = 100
