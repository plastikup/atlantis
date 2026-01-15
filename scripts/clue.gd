extends Area2D
@onready var progress_bar: ProgressBar = $Control/ProgressBar
@onready var timer: Timer = $Timer

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
			progress_bar.value += PROGRESS_SPEED * delta
		else:
			progress_bar.value = 0
		if progress_bar.value == progress_bar.max_value:
			is_done = true
			timer.start()
	else:
		progress_bar.value = 100.0
		
	
func _mouse_enter() -> void:
	is_in_bound = true

func _mouse_exit() -> void:
	is_in_bound = false

func _on_timer_timeout() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	is_in_bound = true


func _on_body_exited(body: Node2D) -> void:
	is_in_bound = false
