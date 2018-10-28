extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var level_path
var status
var level_id = 2

var levels = [["res://Levels/1/1.json", 0],["res://Levels/1/2.json", 0], ["res://Levels/1/3.json", 0]
,["res://Levels/1/4.json", 0] ,["res://Levels/1/5.json", 0] ,["res://Levels/1/6.json", 0],
["res://Levels/1/7.json", 0] ,["res://Levels/1/8.json", 0], ["res://Levels/1/9.json", 0],
["res://Levels/1/10.json", 0] ,["res://Levels/1/11.json", 0] ,["res://Levels/1/12.json", 0]]


func _ready():
	#self.connect("pressed", self, "self_pressed")
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func self_pressed():
		get_node("/root/global").set_level_id(level_id)
		get_tree().change_scene("res://level.tscn")
		#load scene level path
		pass # replace with function body



func set_level_path(val):
	level_path = val
	pass

func get_level_path():
	return level_path

func set_level_id(val):
	level_id = val
	pass

func get_level_id():
	return level_id

func set_status(val):
	status = val
	pass

func get_status():
	return status

