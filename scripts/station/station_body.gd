extends Area2D
const ACTION:= "interact"
var is_inbound := false


func _unhandled_input(event: InputEvent) -> void:
	if is_inbound:
		if event.is_action_pressed(ACTION):
				signalHub.open_shop()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	



func _on_body_entered(body: Node2D) -> void:
	is_inbound = true

func _on_body_exited(body: Node2D) -> void:
	is_inbound = false
