extends Node2D

@export var highestFish = 3
var shown := false
var sectionStart 
var sectionAngle
var chosenFish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defineWinSection()
	signalHub.fish_some_fish.connect(showing)
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shown:
		if Input.is_action_just_pressed("click"):
			if $dial.needleAngle > sectionStart and $dial.needleAngle < sectionStart+sectionAngle:
				defineWinSection()
				PlayerInfo.fish_inv[PlayerInfo.depthLevel] += 1
				print("reussis")
			else:
				print("perdu")
			hide()
			await get_tree().create_timer(0.5).timeout
			shown = false
			signalHub.menu_hide()
		#if needle is in winsection : win and define new win section
		
func showing(_a) -> void:
	shown = true
	show()
	signalHub.menu_popup()
	print("yo")
func defineWinSection():
	chosenFish = determineFish()
	print(chosenFish)
	sectionAngle = determineSectionAngle()
	print(sectionAngle)
	sectionStart = randf_range($dial.minAngle, ($dial.maxAngle-sectionAngle))
	$dial.set_new_color_range([{
	'angle_from': $dial.minAngle,
	'angle_to': $dial.maxAngle,
	'color': Color.WHITE,
}, {
	'angle_from': sectionStart,
	'angle_to': sectionStart+sectionAngle,
	'color': Color.GREEN,
}])

func determineFish():
	var rdm = randf()
	if highestFish == 2:
		if rdm < 0.33:
			return 2
		else : return 1
	elif highestFish == 3:
		if rdm < 0.20:
			return 3
		elif rdm < 0.60:
			return 2
		else :
			return 1 
	elif highestFish == 4 :
		if rdm < 0.10:
			return 4
		elif rdm < 0.25:
			return 3
		elif rdm < 0.60:
			return 2
		else :
			return 1 
	else:
		return 1

func determineSectionAngle() :
	return 2*(1.0-(float(chosenFish)/(float(highestFish)+0.5)))
	
		
