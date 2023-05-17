extends Node2D

var currentSlide = 1

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		currentSlide += 1
		var error = get_tree().change_scene("res://slides/" + ("%02d" % currentSlide) + ".tscn")
		if error != OK:
			currentSlide -= 1
			print("Reached the end of the presentation")
	if Input.is_action_just_pressed("ui_left"):
		currentSlide -= 1
		var error = get_tree().change_scene("res://slides/" + ("%02d" % currentSlide) + ".tscn")
		if error != OK:
			currentSlide += 1
			print("Reached the start of the presentation")
	if Input.is_action_just_pressed("ui_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
