extends Area2D

export var speed = 50
export var direction = Vector2.ZERO

func set_direction(d:Vector2):
	direction = d

func _process(delta):
	position = position + direction * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func die():
	queue_free()

func _on_bullet_area_entered(area):
	die()
	area.die()
