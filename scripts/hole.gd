extends Area2D

const ACTION_LEVEL_SWITCH = "interact"
var in_bound := false

enum HoleTypes { to_bottom, to_surface }
var mode: HoleTypes


func _ready() -> void:
	mode = get_parent().mode

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(ACTION_LEVEL_SWITCH) and in_bound:
		signalHub.switch_scene.emit()


func _on_body_entered(_body: Node2D) -> void:
	in_bound = true


func _on_body_exited(_body: Node2D) -> void:
	in_bound = false
