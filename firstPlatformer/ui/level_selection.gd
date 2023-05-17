extends Node


var levels_directory = "res://levels/"
var dir = Directory.new()
var currentLevel

# Called when the node enters the scene tree for the first time.
func _init():
	printerr("constructor")
	if dir.open(levels_directory) != OK:
		printerr("Warning: could not open directory: ", levels_directory)
	if dir.list_dir_begin(true, true) != OK:
		printerr("Warning: could not list contents of: ", levels_directory)
	currentLevel = dir.get_next()
	if currentLevel == "":
		get_tree().quit()


func load_next_level():
	currentLevel = dir.get_next()
	if currentLevel == "":
		get_tree().quit()
	printerr("next level: ", levels_directory + currentLevel)
	get_tree().change_scene(levels_directory + currentLevel)
