extends TextureRect


@onready var repair_popup:=$MarginContainer/RepairPopup
@onready var repair_btn = $VBoxContainer/MarginContainer2/VBoxContainer/CenterContainer/Repair

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	repair_btn.mouse_entered.connect(repair_hover_enter)
	repair_btn.mouse_exited.connect(repair_hover_exit)

	
func repair_hover_enter() -> void:
	repair_popup.fade_in()
	
func repair_hover_exit() -> void:
	repair_popup.fade_out()
