extends Area2D

var is_in_bound = false
var is_held:= false
var is_done:= false
const PROGRESS_SPEED := 25.0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		is_held = true
	else:
		is_held = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not is_done:
		if is_held and is_in_bound:
			%ProgressBar.value += PROGRESS_SPEED * delta
		else:
			%ProgressBar.value = 0.0
		if %ProgressBar.value == %ProgressBar.max_value:
			is_done = true
			%Timer.start()
	else:
		%ProgressBar.value = 100.0

func _on_timer_timeout() -> void:
	get_parent().queue_free()


func _on_body_entered(body: Node2D) -> void:
	is_in_bound = true


func _on_body_exited(body: Node2D) -> void:
	is_in_bound = false
