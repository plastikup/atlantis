extends Control

@onready var controle = preload("res://scenes/ui/controles_modifiable.tscn")
@onready var liste = $ItemList
var is_remapping = false
var action_to_remap = null
var remapping_button = null
var input_actions = {
	"left": "Tourner à gauche",
	"right": "Tourner à droite",
	"up": "Avancer",
	"down": "Reculer",
	"interact": "Intéragir",
	"fish": "Pêcher",
	"inventaire": "Inventaire"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_create_action_list()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up"):
		print("lololol")

func _create_action_list() -> void:
	InputMap.load_from_project_settings()
	for item in liste.get_children():
		item.queue_free()
	for action in input_actions:
		var button = controle.instantiate()
		var action_label = button.find_child("commandes")
		var input_label = button.find_child("touches")
		action_label.text = input_actions[action]
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			print(events[0])
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		liste.add_child(button)
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		
func _on_input_button_pressed(button, action) -> void:
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("touches").text = "Appuyez sur la touche désirée..."

func _input(event):
	if is_remapping:
		if (
			event is InputEventKey ||
			(event is InputEventMouseButton && event.pressed)
		):
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			is_remapping = false
			action_to_remap = null
			remapping_button = null
			accept_event()

func _update_action_list(button, event):
	button.find_child("touches").text = event.as_text().trim_suffix(" (Physical)")
