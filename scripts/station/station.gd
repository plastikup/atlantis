extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	signalHub.access_shop.connect(showShop)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func showShop() -> void:
	show()


func _on_close_pressed() -> void:
	signalHub.close_shop()
	hide()
