extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var destination = Vector2(766,355)
var direction
var motion 
const speed = 200

func _ready():
	motion = self.rect_position
	set_process(true)
	pass
	
func _process(delta):
	#need to add a range of error you know like 0.2
	if (self.rect_position != destination):
		get_direction()
		motion += direction * speed * delta
		self.rect_position=motion
	else:
		set_process(false)
	pass
	
func get_direction():
	direction= (destination - self.rect_position).normalized()
