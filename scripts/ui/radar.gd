extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for x in PlayerInfo.radarElements:
		var posDif = x.node.global_position - PlayerInfo.playerNode.global_position
		match x.type:
			"clue":
				pass
			"up":
				pass
			"down":
				pass
			"fish":
				pass
