extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var health = 6

func _takedamage():
	health -= 1
	$HealthLabel.text = ("%0*d" % [1, health])
	print(health)
	if health <= 0:
		queue_free()
	
#func _movement():
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
