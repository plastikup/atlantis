extends Node2D

@export var highestFish = 1

var sectionStart 
var sectionAngle
var chosenFish

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defineWinSection()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		if $dial.needleAngle > sectionStart and $dial.needleAngle < sectionStart+sectionAngle:
			defineWinSection()
		#if needle is in winsection : win and define new win section
		
func defineWinSection():
	#get desired fish
	if highestFish > 1:
		var fishTotal = 0 
		for x in highestFish:
			fishTotal += x
	else:
		chosenFish = 1
		sectionAngle = 0.7
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
