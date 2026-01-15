extends Area2D

const ACTION:= "interact"
const FISH:= "fish"
var cooldown_done:= false
var is_inbound := false
@export var level: PlayerInfo.typeLevels

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(ACTION):
		signalHub.build_request(level)
	elif event.is_action_pressed(FISH) and cooldown_done:
		signalHub.fish_some_fish_request(level)

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
