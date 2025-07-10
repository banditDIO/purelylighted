extends CharacterBody2D
const SPEED = 250
var GRAVITY = 500
var mode = 1
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("mode"):
		if mode == 1:
			mode += 1
		else:
			mode -= 1
	if mode == 1:
		var direction = Vector2(
			Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"),
			Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
		)

		velocity = direction.normalized() * SPEED
		move_and_slide()
	if mode == 2:
		if not is_on_floor():
			velocity.y = GRAVITY
		if is_on_floor():
			if Input.is_action_pressed("moveLeft"):
				velocity.x = -SPEED
			if Input.is_action_pressed("moveRight"):
				velocity.x = SPEED
			else:
				velocity.x = 0
	move_and_slide()
	print(velocity.y)
