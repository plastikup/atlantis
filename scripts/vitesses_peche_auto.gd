extends Label

var vitesses = [1, 3, 5, 10, 15]
var upgrade_actuelle_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(vitesses[upgrade_actuelle_index])
