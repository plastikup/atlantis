extends VBoxContainer

@onready var woodFish: Label = $MarginContainer/HBoxContainer/VBoxContainer4/Label
@onready var copperFish: Label = $MarginContainer/HBoxContainer/VBoxContainer3/Label
@onready var silverFish: Label = $MarginContainer/HBoxContainer/VBoxContainer/Label
@onready var goldFish: Label = $MarginContainer/HBoxContainer/VBoxContainer2/Label




func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("1"):
		PlayerInfo.fish_inv[0] += 1
	elif event.is_action_pressed("2"):
		PlayerInfo.fish_inv[1] += 1
	elif event.is_action_pressed("3"):
		PlayerInfo.fish_inv[2] += 1
	elif event.is_action_pressed("4"):
		PlayerInfo.fish_inv[3] += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	woodFish.text = "%04d" % PlayerInfo.fish_inv[0]
	copperFish.text = "%04d" % PlayerInfo.fish_inv[1]
	silverFish.text = "%04d" % PlayerInfo.fish_inv[2]
	goldFish.text = "%04d" % PlayerInfo.fish_inv[3]
