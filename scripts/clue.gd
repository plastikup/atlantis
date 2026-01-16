extends Area2D

var is_in_bound = false
var is_held:= false
var is_done:= false
const PROGRESS_SPEED := 25.0

var depthLevel

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("interact"):
		#is_held = true
	#else:
		#is_held = false

func _ready() -> void:
	depthLevel = get_parent().get_parent().get_parent().name.replace("level", "").to_int()-1
	PlayerInfo.radarElements.append({"type" : "clue", "node" : self, "isNew" : true, "level" : depthLevel}) 
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	is_held = Input.is_action_pressed("interact")
	if not is_done:
		if is_held and is_in_bound:
			%ProgressBar.value += PROGRESS_SPEED * delta
		else:
			%ProgressBar.value = 0.0
		if %ProgressBar.value == %ProgressBar.max_value:
			is_done = true
			%Timer.start()
	else:
		%ProgressBar.value = 100.0

func _on_timer_timeout() -> void:
	PlayerInfo.clues_found[PlayerInfo.depthLevel][0] += 1
	print(PlayerInfo.clues_found[PlayerInfo.depthLevel][0], PlayerInfo.clues_found[PlayerInfo.depthLevel][1])
	signalHub.found_clue_rq()
	get_parent().get_parent().queue_free()


func _on_body_entered(body: Node2D) -> void:
	is_in_bound = true
	signalHub.area_entered("Scan")


func _on_body_exited(body: Node2D) -> void:
	is_in_bound = false
	signalHub.area_entered("leave_fs")
