extends Control


@onready var upgrade_popup:= $HBoxContainer/Shop/MarginContainer/UpgradePopup
@onready var repair_popup:= $HBoxContainer/Repair/MarginContainer/RepairPopup

@onready var upgrade_btn = $HBoxContainer/Shop/VBoxContainer/MarginContainer2/VBoxContainer/CenterContainer/Upgrade
@onready var repair_btn = $HBoxContainer/Repair/VBoxContainer/MarginContainer2/VBoxContainer/CenterContainer/Repair

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_btn.mouse_entered.connect(upgrade_hover_enter)
	upgrade_btn.mouse_exited.connect(upgrade_hover_exit)
	
	repair_btn.mouse_entered.connect(repair_hover_enter)
	repair_btn.mouse_exited.connect(repair_hover_exit)
	

func upgrade_hover_enter() -> void:
	upgrade_popup.fade_in()
	
func upgrade_hover_exit() -> void:
	upgrade_popup.fade_out()
	
func repair_hover_enter() -> void:
	repair_popup.fade_in()
	
func repair_hover_exit() -> void:
	repair_popup.fade_out()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
