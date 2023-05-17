extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var max_floor_speed = Vector2(150, 0)
export var max_air_speed = Vector2(150, 400)
export var floor_acceleration = 45
export var air_acceleration = 15
export var floor_friction = 0.5
export var air_friction = 0.4
export var gravity = Vector2(0, 25)
export var jump_force = 350
var speed = Vector2.ZERO
var is_on_door = false
var is_jumping = false
var can_jump = false

func level_clear():
	$playerVisibilityNotifier.disconnect("screen_exited", self, "_on_playerVisibilityNotifier_screen_exited")
	LevelSelection.load_next_level()

func _physics_process(_delta):
	var friction
	var acceleration
	var max_speed
	if is_on_door and Input.is_action_pressed("ui_select"):
		level_clear()

	var direction = Vector2(Input.get_axis("ui_left", "ui_right"), 0).normalized()
	match is_on_floor():
		true:
			friction = floor_friction
			acceleration = floor_acceleration
			max_speed = max_floor_speed
		false:
			friction = air_friction
			acceleration = air_acceleration
			max_speed = max_air_speed
	if direction == Vector2.ZERO:
		$playerAnimatedSprite.play("idle")
		speed.x -= speed.x * friction
	else:
		$playerAnimatedSprite.play("walking_right")
		speed += direction * acceleration
	if is_on_floor():
		can_jump = true
		is_jumping = false
	elif $coyoteTimer.is_stopped():
		speed += gravity
		can_jump = false
	
	if Input.is_action_pressed("ui_accept") and can_jump:
		is_jumping = true
		can_jump = false
		var jump_speed = (direction * air_friction + Vector2.UP) * jump_force
		speed += jump_speed
		max_speed = max_air_speed

	
	var was_on_floor = is_on_floor()
	speed.x = clamp(speed.x, -max_speed.x, max_speed.x)
	speed.y = clamp(speed.y, -max_speed.y, max_speed.y)
	speed = move_and_slide(speed, Vector2(0, -1))
	if not is_on_floor() and was_on_floor and not is_jumping:
		$coyoteTimer.start()
		speed.y = 0




func die():
	get_tree().reload_current_scene()

func _on_playerVisibilityNotifier_screen_exited():
	printerr("Out of bounds!")
	die()
