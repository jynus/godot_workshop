extends StaticBody2D

var can_continue = false

func _ready():
	pass # Replace with function body.

func _input(event):
	if can_continue and event is InputEventKey and event.pressed and event.scancode in [KEY_ENTER, KEY_SPACE]:
		print("pressed escape after game over")
		get_tree().paused = false
		reset()

func _on_goal_body_entered(body):
	get_tree().paused = true
	$AnimationPlayer.play("game_over")

func reset():
	get_tree().reload_current_scene()


func _on_AnimationPlayer_animation_finished(anim_name):
	can_continue = true
