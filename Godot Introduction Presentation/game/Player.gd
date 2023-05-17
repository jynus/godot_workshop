extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ball = preload("res://game/Ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	position.x = get_viewport().get_mouse_position().x
	if get_parent().visible and Input.is_action_just_pressed("ui_fire"):
		var b = ball.instance()
		get_parent().add_child(b)
		b.position = global_position + Vector2(0, -50)
		b.velocity = Vector2(500, -300)
		$AudioStreamPlayer.play()
		var music = get_parent().get_node("music")
		if not music.playing:
			music.play()




