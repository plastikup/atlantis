extends Control
@onready var upgrade_btn := $"image bois/upgrade button"
@onready var upgrade_popup := $"image bois/CostPopup"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_btn.mouse_entered.connect(upgrade_hover_enter)
	upgrade_btn.mouse_exited.connect(upgrade_hover_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func upgrade_hover_enter() -> void:
	upgrade_popup.fade_in()
	
func upgrade_hover_exit() -> void:
	upgrade_popup.fade_out()
