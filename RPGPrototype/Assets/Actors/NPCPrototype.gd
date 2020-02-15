extends KinematicBody2D


#total health  
var health = 50
#placeholder var for d20 roll
var randdamage


func _ready():
	#show health label at level load
	$HealthLabel.text = ("%0*d" % [2, health])


#function called when player attacks this npc
func _takedamage():
	#d20 roll
	randdamage = randi()%21+1
	print("Damage:", randdamage)
	#damage subtracted from health
	health -= randdamage
	#update health label when hit
	$HealthLabel.text = ("%0*d" % [2, health])
	print(health)
	#death check
	if health <= 0:
		queue_free()
	


