extends KinematicBody2D

var velocity = Vector2.ZERO
export var max_velocity = 25
onready var animationTree = $AnimationTree
onready var shootTimer = $shootTimer
onready var walkingSound = $walkingSound
onready var shootingSound = $shootingSound
onready var bullet = preload("res://scenes/Bullet.tscn")

var can_shoot = true

func shoot(direction:Vector2):
	can_shoot = false
	if direction == Vector2.ZERO:
		direction = Vector2.DOWN  # default to down
	var b = bullet.instance()
	b.position = global_position + direction * 10
	b.set_direction(direction.normalized())
	get_parent().add_child(b)
	shootingSound.play()
	shootTimer.start()

func _on_shootTimer_timeout():
	can_shoot = true

func movement_sound(direction:Vector2):
	if direction == Vector2.ZERO:
		if walkingSound.playing:
			walkingSound.stop()
	elif not walkingSound.playing:
		walkingSound.play()
		
func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	animationTree.set("parameters/walk/blend_position", direction)
	movement_sound(direction)
	if can_shoot and Input.is_action_just_pressed("ui_accept"):
		shoot(direction)
	velocity = direction * max_velocity
	velocity = move_and_slide(velocity)

func die():
	get_tree().quit()
