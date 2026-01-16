extends Area2D

const ACTION:= "interact"
const FISH:= "fish"
@export var is_inbound := false
@export var clue_all_found := false
@export var level: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signalHub.found_clue.connect(verify_clue_found)
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if clue_all_found:
		if is_inbound:
			if Input.is_action_pressed(FISH):
				print("FISHIIIIIING")
				signalHub.fish_some_fish_request(level)
			elif Input.is_action_pressed(ACTION) and clue_all_found:
				print("build")
				signalHub.build_request(level)

func _on_body_entered(body: Node2D) -> void:
	is_inbound = true


func _on_body_exited(body: Node2D) -> void:
	is_inbound = false
	
func verify_clue_found() -> void:
	if PlayerInfo.clues_found[level][0] >= PlayerInfo.clues_found[level][1]:
		print(PlayerInfo.clues_found[level][0], PlayerInfo.clues_found[level][1])
		show()
		clue_all_found = true
