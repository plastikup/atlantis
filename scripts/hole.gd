extends Area2D

const ACTION_LEVEL_SWITCH = "interact"
var in_bound := false

enum HoleTypes { to_bottom, to_surface }


func _ready() -> void:
	signalHub.switch_scene.connect(apply_shades)
	apply_shades()

func apply_shades() -> void:
	await get_tree().create_timer(1.0).timeout
	
	if get_parent().layer-1 == PlayerInfo.depthLevel:
		%ColorRect.color = '#00000066'
		print(1)
	else:
		%ColorRect.color = '#FFFFFF66'
		print(2)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(ACTION_LEVEL_SWITCH) and in_bound:
		PlayerInfo.depthLevel += 1 if get_parent().layer-1 == PlayerInfo.depthLevel else -1
		signalHub.switch_scene.emit()
		print(PlayerInfo.depthLevel)


func _on_body_entered(_body: Node2D) -> void:
	in_bound = true

func _on_body_exited(_body: Node2D) -> void:
	in_bound = false
