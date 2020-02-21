extends KinematicBody2D


onready var player = get_node("/root/TestLevel/Player")
onready var enemyraycast = get_node("NPC_Raycast")

#total health  
var health = 50
#placeholder var for d20 roll
var randdamage
var alive = true
var randmovement
var PlayerPosition
var velocity = Vector2()
export (int) var speed = 75
var engaged = false


func _ready():
	#show health label at level load
	$HealthLabel.text = ("%0*d" % [2, health])
	randomize()
	$Timer.start()


#function called when player attacks this npc
func _takedamage():
	engaged = true
	#d20 roll
	randdamage = randi()%20+1
	if randdamage == 1:
		player._unlucky()
	#damage subtracted from health
	else: health -= randdamage
	#update health label when hit
	$HealthLabel.text = ("%0*d" % [2, health])
	print("Roll:", randdamage)
	#death check
	if health <= 0:
		queue_free()


func _movement():
	if engaged == false:
		velocity = Vector2()
		randmovement = randi()%4+1
		if randmovement == 1:
			#right
			velocity.x += 1
			rotation_degrees = 90
		elif randmovement == 2:
			#left
			velocity.x -= 1
			rotation_degrees = 270
		elif randmovement == 3:
			#down
			velocity.y += 1
			rotation_degrees = 180
		elif randmovement == 4:
			#up
			velocity.y -= 1
			rotation_degrees = 0
		velocity = velocity.normalized() * speed
		$Timer2.start()
	

func _on_Timer_timeout():
	_movement()


func _on_Timer2_timeout():
	velocity = Vector2()


func _physics_process(_delta):
	velocity = move_and_slide(velocity)
	if engaged == true:
		_attack_player()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		engaged = true


func _attack_player():
	velocity = Vector2()
	velocity = (player.position - position).normalized() * speed
	if velocity.x >= 50:
		rotation_degrees = 90
	elif velocity.x <= -50:
		rotation_degrees = 270
	elif velocity.y >= 50 && velocity.y > velocity.x:
		rotation_degrees = 180
	elif velocity.y <= -50 && velocity.y < velocity.x:
		rotation_degrees = 0
	if enemyraycast.is_colliding():
		var enemycollider = enemyraycast.get_collider()
		if enemycollider.is_in_group("player"):
			player._unlucky()


func _on_Escape_Area2D_body_exited(body):
	if body.is_in_group("player"):
		engaged = false
