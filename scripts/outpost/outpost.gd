extends StaticBody2D

@export var production:= 5.0
var level := 0 # will be initialized by level

const ACTION:= "interact"
var is_inbound := false


func _unhandled_input(event: InputEvent) -> void:
	if is_inbound:
		if event.is_action_pressed(ACTION):
				signalHub.open_shop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	is_inbound = true

func _on_body_exited(body: Node2D) -> void:
	is_inbound = false



func _on_timer_timeout() -> void:
	PlayerInfo.fish_inv[level] += production
