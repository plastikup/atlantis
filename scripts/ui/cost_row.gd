extends Node

@onready var fish: TextureRect = $TextureRect
@onready var countTxt: Label = $Count

const fishImgs = {
	PlayerInfo.typeLevels.wood: preload("res://assets/fish/wooden.png"),
	PlayerInfo.typeLevels.silver: preload("res://assets/fish/silver.png"),
	PlayerInfo.typeLevels.copper: preload("res://assets/fish/copper.png"),
	PlayerInfo.typeLevels.gold: preload("res://assets/fish/gold.png")
}


func loadData(fishType: PlayerInfo.typeLevels, count: int, fontColor: Color):
	fish.texture = fishImgs[fishType]
	countTxt.text = "X %s" % count
	countTxt.add_theme_color_override("font_color", fontColor)
	
