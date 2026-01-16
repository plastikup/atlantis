extends CanvasLayer

var currentInputs := []
@onready var inputElement = preload("res://scenes/ui/inputElement.tscn")
var showing:= true


func _ready() -> void:
	#addInput("up", "Avancer", "up")
	#addInput("left", "Aller à gauche", "left")
	#addInput("down", "Reculer", "down")
	#addInput("right", "Aller à droite", "right")
	signalHub.access_shop.connect(open_shop)
	signalHub.hide_shop.connect(hide_shop)
	signalHub.access_outpost.connect(open_outpost)
	signalHub.leave_outpost.connect(hide_shop)
	signalHub.in_bound_area.connect(show_input_dependant)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentInputs.size() == 0 :
		self.visible = false
	elif showing:
		self.visible = true

func addInput(id:String, text:String, icon:String) :
	currentInputs.append({"id" : id, "text" : text, "icon" : icon})
	#drawInputs()
	
func removeInput(id:String):
	for input in currentInputs:
		if input.id == id:
			currentInputs.erase(input)
			return
	drawInputs()

func drawInputs():
	for x in $Control/BoxContainer/HBoxContainer/VBoxContainer.get_children():
		x.queue_free()
	for input in currentInputs:
		var element = inputElement.instantiate()
		$Control/BoxContainer/HBoxContainer/VBoxContainer.add_child(element)
		element.get_node("Label").text = input.text
		element.get_node("TextureRect").texture.path = input.icon # n'affiche que le dernier!! 
		
func hide_shop() -> void:
	showing = true
	show()
	
func open_shop() -> void:
	showing = false
	hide()
	
func open_outpost(level) -> void:
	showing = false
	hide()
	
func show_input_dependant(area) -> void:
	if area == "Pêcher":
		addInput("interact", "Pêchotron 3000", "interact")
		addInput("fish", "Pêcher", "fish")
		drawInputs()
	elif area == "Station":
		addInput("interact", "Station", "interact")
		drawInputs()
	elif area == "Scan":
		addInput("interact", "Scanner", "interact")
		drawInputs()
	elif area == "leave_fs":
		removeInput("interact")
		removeInput("fish")
		drawInputs()
	elif area == "leave_station":
		removeInput("interact")
		drawInputs()
		
