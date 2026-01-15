extends Node2D


@export var CURRERT_LEVEL := 2


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#var current_scene = load("res://scenes/world/level" + str(CURRERT_LEVEL) + ".tscn").instantiate()
	#get_tree().root.call_deferred("add_child", current_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
