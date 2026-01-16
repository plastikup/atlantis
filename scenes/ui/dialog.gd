extends Control

const dialogs = [["res://ressources/dialogic/timelines/cousteau/cousteau1.dtl"],["res://ressources/dialogic/timelines/cousteau/cousteau2.dtl", "res://ressources/dialogic/timelines/cousteau/cousteau3.dtl", "res://ressources/dialogic/timelines/cousteau/cousteau4.dtl"],
["res://ressources/dialogic/timelines/oceangate/oceangate1.dtl", "res://ressources/dialogic/timelines/oceangate/oceangate2.dtl", "res://ressources/dialogic/timelines/oceangate/oceangate4.dtl"],
["res://ressources/dialogic/timelines/titanic/titanic1.dtl", "res://ressources/dialogic/timelines/titanic/titanic2.dtl", "res://ressources/dialogic/timelines/titanic/titanic4.dtl"], 
["res://ressources/dialogic/timelines/atlantis/atlantis2.dtl", "res://ressources/dialogic/timelines/atlantis/atlantis3.dtl", "res://ressources/dialogic/timelines/atlantis/atlantis4.dtl"]]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	signalHub.found_clue.connect(launch_dialog)
	
func launch_dialog(level: int, id: int) -> void:
	Dialogic.start(dialogs[level][id])
	Dialogic.timeline_ended.connect(on_dialog_finished)
	signalHub.menu_popup()
	
func on_dialog_finished():
	signalHub.menu_hide()
