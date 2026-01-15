extends RichTextLabel

var prix = [10, 25, 50, 100]
var vitesses = [1, 3, 5, 10, 15]
var upgrade_actuelle_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	clear()
	if upgrade_actuelle_index == 4:
		append_text("[font=res://assets/BlackOpsOne-Regular.ttf][font_size=35]Upgrade max atteinte!\n \nVitesse actuelle: \n%d poissons par seconde [/font_size][/font]" % vitesses[upgrade_actuelle_index])
	elif upgrade_actuelle_index > 0 and upgrade_actuelle_index:
		append_text("[font=res://assets/BlackOpsOne-Regular.ttf][font_size=35]Prix: %d poissons\n \nVitesse actuelle: \n%d poissons par seconde [/font_size][/font]" % [prix[upgrade_actuelle_index], vitesses[upgrade_actuelle_index]])
	else:
		append_text("[font=res://assets/BlackOpsOne-Regular.ttf][font_size=35]Prix: %d poissons\n \nVitesse actuelle: \n%d poisson par seconde [/font_size][/font]" % [prix[upgrade_actuelle_index], vitesses[upgrade_actuelle_index]])

func _on_upgrade_button_pressed() -> void:
	if upgrade_actuelle_index < 4:
		upgrade_actuelle_index += 1
