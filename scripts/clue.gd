extends Area2D
@onready var progress_bar: ProgressBar = $Control/ProgressBar


var is_held:= false

func _on_area2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			print("Click started")
			is_held = true
		else:
			print("Click released")
			is_held = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if progress_bar.value < 100.0:
		progress_bar.value += 5.0 * delta
	
