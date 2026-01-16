extends Control

@onready var radarElement = preload("res://scenes/ui/radarElement.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for x in PlayerInfo.radarElements:
		if x.isNew:
			x.isNew = false
			var newElement = radarElement.instantiate()
			newElement.associatedNode = x.node
			$elements.add_child(newElement)
				
			match x.type:
				"clue":
					newElement.modulate = Color.GREEN
				"up":
					newElement.modulate = Color.AQUA
				"down":
					newElement.modulate = Color.BLUE
				"fish":
					newElement.modulate = Color.YELLOW
			


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.get_parent().name == "elements":
		body.modulate.a = 1
		body.get_node("ping").play()
		var tween = create_tween()
		tween.tween_property(body, "modulate:a", 0, 1)

func active(value):
	print("sonar b")
	$AnimationPlayer.active = value
	visible = value
