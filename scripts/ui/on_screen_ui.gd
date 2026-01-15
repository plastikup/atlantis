extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$dial.set_needle_angle(PlayerInfo.depthLevel * 2*PI/4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
