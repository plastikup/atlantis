extends Control
@onready var cost_rows: VBoxContainer = $TextureRect/MarginContainer/Rows

var costs_list: Array

var fade_time = 0.15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# clear out placeholder rows
	for row in cost_rows.get_children():
		row.queue_free()
		
	modulate.a = 0
	
func set_cost_infos() -> void:
	pass

func fade_out() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.from_rgba8(255,255,255,0), fade_time)
	

func fade_in() -> void:
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.from_rgba8(255,255,255,255), fade_time)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
