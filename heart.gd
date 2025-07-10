extends CharacterBody2D

const SPEED = 250
var GRAVITY = 500
var drag_speed = 5000
var dragging_enabled = true
var mode = 2

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("mode"):
		mode += 1
		if mode > 3:
			mode = 1

	match mode:
		1:
			var direction = Vector2(
				Input.get_action_strength("moveRight") - Input.get_action_strength("moveLeft"),
				Input.get_action_strength("moveDown") - Input.get_action_strength("moveUp")
			)
			velocity = direction.normalized() * SPEED
			move_and_slide()

		2:
			if not is_on_floor():
				velocity.y += GRAVITY * delta
			else:
				velocity.y = 0 
				if Input.is_action_pressed("moveLeft"):
					velocity.x = -SPEED
				elif Input.is_action_pressed("moveRight"):
					velocity.x = SPEED
				else:
					velocity.x = 0
			move_and_slide()
			print(velocity.y)

		3:  
			if dragging_enabled and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
				var target = get_global_mouse_position()
				var direction = target - global_position
				var distance = direction.length()

				var max_move = drag_speed * delta
				if distance > max_move:
					direction = direction.normalized() * max_move

				move_and_collide(direction)
