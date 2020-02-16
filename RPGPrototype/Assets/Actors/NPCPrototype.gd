extends KinematicBody2D


#total health  
var health = 50
#placeholder var for d20 roll
var randdamage
onready var player = get_node("/root/TestLevel/Player")
var alive = true
var randmovement
var velocity = Vector2()
export (int) var speed = 100


func _ready():
	#show health label at level load
	$HealthLabel.text = ("%0*d" % [2, health])
	randomize()
	$Timer.start()


#function called when player attacks this npc
func _takedamage():
	#d20 roll
	randdamage = randi()%20+1
	if randdamage == 1:
		player._unlucky()
	#damage subtracted from health
	else: health -= randdamage
	#update health label when hit
	$HealthLabel.text = ("%0*d" % [2, health])
	print("Roll:", randdamage)
	print(health)
	#death check
	if health <= 0:
		queue_free()
	
func _movement():
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
	
	
func _physics_process(_delta):
	velocity = move_and_slide(velocity)


func _on_Timer2_timeout():
	velocity = Vector2()
