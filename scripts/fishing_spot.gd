extends Area2D

const ACTION:= "interact"
const FISH:= "fish"
var is_inbound := false
@export var clue_all_found := false
@export var level: int

func _unhandled_input(event: InputEvent) -> void:
	if clue_all_found:
		if is_inbound:
			if event.is_action_pressed(FISH):
				print("FISHIIIIIING")
				signalHub.fish_some_fish_request(level)
			elif event.is_action_pressed(ACTION) and clue_all_found:
				signalHub.build_request(level)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	signalHub.connect("found_clue", verify_clue_found)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	is_inbound = true


func _on_body_exited(body: Node2D) -> void:
	is_inbound = false
	
func verify_clue_found(level) -> void:
	if PlayerInfo.clues_found[level][0] >= PlayerInfo.clues_found[level][1]:
		show()
		clue_all_found = true
