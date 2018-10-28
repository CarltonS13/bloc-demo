extends Node2D

var sol_pressed = 0

var tmp_dict = {}

var sol

var current_level = 2

var level_desc = "fskdb"
var levels = [["res://Levels/1/1.json", 0],["res://Levels/1/2.json", 0], ["res://Levels/1/3.json", 0] 
,["res://Levels/1/4.json", 0] ,["res://Levels/1/5.json", 0] ,["res://Levels/1/6.json", 0], 
["res://Levels/1/7.json", 0] ,["res://Levels/1/8.json", 0], ["res://Levels/1/9.json", 0], 
["res://Levels/1/10.json", 0] ,["res://Levels/1/11.json", 0] ,["res://Levels/1/12.json", 0]]

func _ready():
	current_level = get_node("/root/global").get_level_id()
	load_level(levels[current_level-1][0])
	load_sol()
	get_node("grid").start()
	set_count(tmp_dict["max_moves"])
	get_node("description").set_text(tmp_dict["desc"])
	#start_intro()
	pass
	
func start_intro():
	get_node("intro/id").set_text(str(current_level))
	get_node("intro/desc").set_text(level_desc)
	get_node("anim").play("intro")
	pass
	
func get_dictionary():
	return tmp_dict
# uses current_grid and grid to create a grid of blocks
# via create_bloc

func load_sol():
	sol = load(tmp_dict["solution_path"])
	get_node("sol").set_normal_texture(sol)
	get_node("sol").rect_position = Vector2(0,0)
	get_node("sol").rect_position = (Vector2(683,383) - true_center("sol"))
	get_node("sol").set_scale(Vector2(1,1))
	sol_pressed = 1
	pass

#calcs the offset for an image to appear to be in the center accounting for the scaled size of the node
func true_center(name):
	return (get_node(name).get_size() / 2)


	
func load_level(path_to_json):
	#"res://initlevel.json"
	var savelevel = File.new()
	if !savelevel.file_exists(path_to_json):
		print("error")
		return #Error!  We don't have a level to load
	savelevel.open(path_to_json, File.READ)
	tmp_dict=parse_json(savelevel.get_as_text())
	savelevel.close()
	#print("loaded ", tmp_dict)
	#load_dict()
	##print(grid)
	pass



func _on_sol_pressed():
	if (sol_pressed == 0):
		get_node("sol").set_normal_texture(sol)
		get_node("sol").rect_position = (Vector2(683,383) - true_center("sol"))
		get_node("sol").set_scale(Vector2(1,1))
		sol_pressed = 1
	else:
		get_node("sol").set_normal_texture(sol)
		get_node("sol").rect_position =(Vector2(1092.8,383) - (Vector2(75,75)))
		get_node("sol").set_scale(Vector2(0.25,0.25))
		sol_pressed = 0
	pass 
	
	
func set_count(val):
	get_node("moves").set_text(val)
	
#perform success animation
func success(moves):
	get_node("success").show()
	#get_node("anim").play("succ")
	pass
	
#perform failure animation
func fail(moves):
	pass

func load_levels(path_to_json):
	#"res://initlevel.json"
	var savelevel = File.new()
	if !savelevel.file_exists(path_to_json):
		#print("error")
		return #Error!  We don't have a level to load
	savelevel.open(path_to_json, File.READ)
	tmp_dict=parse_json(savelevel.get_as_text())
	savelevel.close()
	#print("saved ", tmp_dict)
	load_dict()
	##print(grid)
	refresh_grid()
	pass

func save_status(file_path):
	var save_dict = levels 
	var savelevel = File.new()
	savelevel.open(file_path, File.WRITE)
	savelevel.store_string(save_dict.to_json())
	savelevel.close()
	#print("stored ", save_dict.to_json())
	pass


func _on_levels_pressed():
	get_tree().change_scene("res://loader.tscn")
	pass # replace with function body


func _on_success_pressed():
	get_tree().change_scene("res://loader.tscn")
	pass # replace with function body
