extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
onready var PlayerRaycast = get_node("PlayerRaycast")

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('movement_right'):
		velocity.x += 1
		rotation_degrees = 90
	if Input.is_action_pressed('movement_left'):
		velocity.x -= 1
		rotation_degrees = 270
	if Input.is_action_pressed('movement_down'):
		velocity.y += 1
		rotation_degrees = 180
	if Input.is_action_pressed('movement_up'):
		velocity.y -= 1
		rotation_degrees = 0
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed('action_attack'):
		print("attack!")
		_attack()

func _attack():
	if PlayerRaycast.is_colliding():
		var collider = PlayerRaycast.get_collider()
		if collider.is_in_group("enemy"):
			collider._takedamage()

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
