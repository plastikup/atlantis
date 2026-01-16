extends StaticBody2D

var associatedNode
var radarScreenPos
var clamps = 105
var posdivider = 90

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	radarScreenPos = get_parent().get_parent().position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if associatedNode:
		var posDif = associatedNode.global_position - PlayerInfo.playerNode.global_position
		var elementPos = radarScreenPos + (posDif/posdivider).normalized() * clamp((posDif/posdivider).length(), 0, 105)
		self.position = elementPos
		#print(elementPos)
