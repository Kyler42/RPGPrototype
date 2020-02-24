extends KinematicBody2D


#player speed
export (int) var speed = 200


var velocity = Vector2()
onready var PlayerRaycast = get_node("PlayerRaycast")
var playerhealth = 6
var vulnerable = true
var walking = false

#movement and attack maps 
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('movement_right'):
		velocity.x += 1
		$PlayerRaycast.rotation_degrees = 90
		$PlayerDownAnimatedSprite.play("rightwalking")
	if Input.is_action_pressed('movement_left'):
		velocity.x -= 1
		$PlayerRaycast.rotation_degrees = 270
		$PlayerDownAnimatedSprite.play("leftwalking")
	if Input.is_action_pressed('movement_down'):
		velocity.y += 1
		$PlayerRaycast.rotation_degrees = 180
		$PlayerDownAnimatedSprite.play("frontwalking")
	#else: $PlayerDownAnimatedSprite.stop()
	if Input.is_action_pressed('movement_up'):
		velocity.y -= 1
		$PlayerRaycast.rotation_degrees = 0
		$PlayerDownAnimatedSprite.play("backwalking")
	velocity = velocity.normalized() * speed
	if Input.is_action_just_pressed('action_attack'):
		_attack()
	if Input.is_action_just_pressed('action_interact'):
		_interact()


#when attack button is clicked, check if it was on an enemy and move to damage
func _attack():
	if PlayerRaycast.is_colliding():
		var collider = PlayerRaycast.get_collider()
		if collider.is_in_group("enemy"):
			collider._takedamage()
			
func _interact():
	if PlayerRaycast.is_colliding():
		var collider = PlayerRaycast.get_collider()
		if collider.is_in_group("speaker"):
			collider._talk()

func _unlucky():
	if vulnerable == true:
		playerhealth -= 1
		vulnerable = false
		$Vulnerability_Timer.start()
		print(playerhealth)
		if playerhealth <= 0:
# warning-ignore:return_value_discarded
			get_tree().reload_current_scene()

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	if velocity == Vector2():
		$PlayerDownAnimatedSprite.stop()



func _on_Vulnerability_Timer_timeout():
	vulnerable = true
