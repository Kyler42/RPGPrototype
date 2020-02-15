extends KinematicBody2D


#total health  
var health = 500
#placeholder var for d20 roll
var randdamage
onready var player = get_node("/root/TestLevel/Player")

func _ready():
	#show health label at level load
	$HealthLabel.text = ("%0*d" % [2, health])
	randomize()


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
	


