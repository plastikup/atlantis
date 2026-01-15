extends CanvasLayer

var currentInputs := []
@onready var inputElement = preload("res://scenes/ui/inputElement.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if currentInputs.size() == 0 :
		self.visible = false
	else :
		self.visible = true

func addInput(id:String, text:String, icon:String) :
	currentInputs.append({"id" : id, "text" : text, "icon" : icon})
	drawInputs()
	
func removeInput(id:String):
	for input in currentInputs:
		if input.id == id:
			currentInputs.erase(input)
			return
	drawInputs()

func drawInputs():
	for input in currentInputs:
		var element = inputElement.instantiate()
		$Control/BoxContainer/HBoxContainer/VBoxContainer.add_child(element)
		element.get_node("Label").text = input.text
		element.get_node("TextureRect").texture.path = input.icon
		
