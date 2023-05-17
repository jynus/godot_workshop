extends Area2D

export var max_speed = 10
export var direction = Vector2(-1, 0)
var alive = true
onready var diePlayer = $diePlayer
onready var label = $Label
onready var collision = $collisionShape
onready var dieAnimation = $AnimationPlayer

func _ready():
	randomize()
	label.text = str(randi() % 90 - 100)

func _process(delta):
	if alive:
		position += direction * max_speed * delta

func die():
	alive = false
	collision.set_deferred("disabled", true)
	dieAnimation.play("die")
	diePlayer.play()

func _on_diePlayer_finished():
	queue_free()


func _on_enemy_body_entered(body):
	body.die()
