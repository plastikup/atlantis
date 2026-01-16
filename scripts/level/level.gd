extends Node2D

const OUTPOST = preload("uid://crpmwhl2n5tgq")
@onready var fishing_spot: Area2D = $fishing_spot
@export var levelID: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signalHub.fishing_spot_br.connect(build_outpost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func build_outpost(_level) -> void:
	var outpost_new := OUTPOST.instantiate()
	add_child(outpost_new)
	outpost_new.position = fishing_spot.position
	outpost_new.level = levelID
