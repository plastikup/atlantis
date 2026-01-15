extends Area2D

const ACTION_LEVEL_SWITCH = "left"
var in_bound := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(ACTION_LEVEL_SWITCH) and in_bound:
		level_switch()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func level_switch():
	pass


func _on_body_entered(body: Node2D) -> void:
	in_bound = true


func _on_body_exited(body: Node2D) -> void:
	in_bound = false
