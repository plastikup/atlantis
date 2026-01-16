extends Area2D

const ACTION:= "interact"
const FISH:= "fish"
@export var is_inbound := false
@export var clue_all_found := false
@export var level: int = 0
var isOutpostOpen := false
var isHeld := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signalHub.found_clue.connect(verify_clue_found)
	hide()
	isOutpostOpen = false
	isHeld = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if clue_all_found:
		if is_inbound:
			if Input.is_action_just_pressed(FISH):
				print("FISHIIIIIING")
				signalHub.fish_some_fish_request(level)
			elif Input.is_action_just_pressed(ACTION) and clue_all_found:
				if not isOutpostOpen:
					signalHub.open_outpost(level)
					signalHub.menu_popup()
					isOutpostOpen = true
				else:
					signalHub.exit_outpost()
					signalHub.menu_hide()
					isOutpostOpen = false

func _on_body_entered(body: Node2D) -> void:
	is_inbound = true


func _on_body_exited(body: Node2D) -> void:
	is_inbound = false
	
func verify_clue_found() -> void:
	if PlayerInfo.clues_found[level][0] >= PlayerInfo.clues_found[level][1]:
		show()
		clue_all_found = true
