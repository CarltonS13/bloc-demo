extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#path to JSON of level paths
var level_source = ""
var levels = [["res://Levels/1/1.json", 2],["res://Levels/1/2.json", 1], ["res://Levels/1/3.json", 1] 
,["res://Levels/1/4.json", 1] ,["res://Levels/1/5.json", 1] ,["res://Levels/1/6.json", 1], 
["res://Levels/1/7.json", 1] ,["res://Levels/1/8.json", 1], ["res://Levels/1/9.json", 1], 
["res://Levels/1/11.json", 1] ,["res://Levels/1/11.json", 1] ,["res://Levels/1/12.json", 0]]

var textures = [preload("res://Textures/Misc/grey.png"),preload("res://Textures/Misc/green.png"),preload("res://Textures/Misc/gold.png")]

var button_script = preload("res://level_choice.gd")

var node 
func _ready():
	load_levels()
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#loads JSON
func load_source():
	pass
	
#takes level info from JSON and places in array
func load_levels():
	for i in range(levels.size()):
		create_bloc(i,levels[i-1][0],levels[i-1][1])
	pass 
	

#creates blocs based on information in dictionary  
func create_bloc(index, level_id, status):
	node = TextureButton.new()
	node.set_normal_texture(textures[status])
	node.set_script(button_script)
	node.set_level_id(index+1)
	node.set_status(status)
	node.connect("pressed", node, "self_pressed")
	get_node("level grid").add_child(node)
	pass