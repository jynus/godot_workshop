extends KinematicBody2D

export var initial_position = Vector2(0, 0)
export var velocity = Vector2(500, -500)
onready var audioPlayer = $AudioStreamPlayer

func _ready():
	position = initial_position


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		audioPlayer.play()
