extends Node2D

var pos1 
var name1 
var id1
var pos2 
var name2 
var id2
var clicked = 0
var first_id

var sol_pos
var sol_name 
var sol_id
var sol_index
var sol_clicked = 0

var steps_so_far = 0
var optimum_steps = 1
var maximum_steps = 3

var level_id
var file_path
var level_desc

var sol=""

var temp_dict = {}
# det exts from text edit and save
# modify load level
#dictionary of all possible grid positions
#eg. ( 1: (Vector2(-10, -30))
var grid = { 43: (Vector2(458, 609)), 44: (Vector2(533, 609)), 45: (Vector2(608, 609)), 46: (Vector2(683, 609)), 47: (Vector2(758, 609)), 48: (Vector2(833, 609)), 49:(Vector2(908, 609)), 
36: (Vector2(458, 534)), 37: (Vector2(533, 534)), 38: (Vector2(608, 534)), 39: (Vector2(683, 534)), 40: (Vector2(758, 534)), 41: (Vector2(833, 534)), 42:(Vector2(908, 534)),
29: (Vector2(458, 459)), 30: (Vector2(533, 459)), 31: (Vector2(608, 459)), 32: (Vector2(683, 459)), 33: (Vector2(758, 459)), 34: (Vector2(833, 459)), 35:(Vector2(908, 459)),
22: (Vector2(458, 384)), 23: (Vector2(533, 384)), 24: (Vector2(608, 384)), 25: (Vector2(683, 384)), 26: (Vector2(758, 384)), 27: (Vector2(833, 384)), 28:(Vector2(908, 384)),
15: (Vector2(458, 309)), 16: (Vector2(533, 309)), 17: (Vector2(608, 309)), 18: (Vector2(683, 309)), 19: (Vector2(758, 309)), 20: (Vector2(833, 309)), 21:(Vector2(908, 309)),
8: (Vector2(458, 234)), 9: (Vector2(533, 234)), 10: (Vector2(608, 234)), 11: (Vector2(683, 234)), 12: (Vector2(758, 234)), 13: (Vector2(833, 234)), 14:(Vector2(908, 234)),
1: (Vector2(458, 159)), 2: (Vector2(533, 159)), 3: (Vector2(608, 159)), 4: (Vector2(683, 159)), 5: (Vector2(758, 159)), 6: (Vector2(833, 159)), 7:(Vector2(908, 159))} 


#solution positions and types 
#Eg, A block1 (blue at position 2 (1 , 2)
var solution_grid = [
[1, 0] , [2, 0] , [3, 0] , [4, 0] , [5, 0] , [6, 0] , [7, 0] ,
[8, 0] , [9, 0] , [10, 0] , [11, 0] , [12, 0] , [13, 0] , [14, 0] ,
[15, 0] , [16, 0] , [17, 0] , [18, 0] , [19, 0] , [20, 0] , [21, 0] ,
[22, 0] , [23, 0] , [24, 0] , [25, 0] , [26, 0] , [27, 0] , [28, 0] ,
[29, 0] , [30, 0] , [31, 0] , [32, 0] , [33, 0] , [34, 0] , [35, 0] ,
[36, 0] , [37, 0] , [38, 0] , [39, 0] , [40, 0] , [41, 0] , [42, 0] ,
[43, 0] , [44, 0] , [45, 0] , [46, 0] , [47, 0] , [48, 0] , [49, 0] ]

var textures = [[0,0], 
[1,0], [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7], [6,0], [0,0],
[2,0], [2,1], [2,2], [2,3], [2,4], [2,5], [2,6], [2,7], [0,0], [0,0],
[3,0], [3,1], [3,2], [3,3], [3,4], [3,5], [3,6], [3,7], [0,0], [0,0],
[4,0], [4,1], [4,2], [4,3], [4,4], [4,5], [4,6], [4,7], [0,0], [0,0],
[5,0], [5,1], [5,2], [5,3], [5,4], [5,5], [5,6], [5,7], [0,0], [0,0]]

var bloc
var sol_bloc_script = preload("res://Engine/bloc_sol.gd")

var blocs = [[[preload("res://Textures/0/gray.png")]],[[preload("res://Textures/1/Normal/11.png"),preload("res://Textures/1/Normal/12.png"),preload("res://Textures/1/Normal/13.png"),preload("res://Textures/1/Normal/14.png"),preload("res://Textures/1/Normal/15.png"),preload("res://Textures/1/Normal/16.png"),preload("res://Textures/1/Normal/17.png"),preload("res://Textures/1/Normal/18.png")],
[preload("res://Textures/1/Hover/11.png"),preload("res://Textures/1/Hover/12.png"),preload("res://Textures/1/Hover/13.png"),preload("res://Textures/1/Hover/14.png"),preload("res://Textures/1/Hover/15.png"),preload("res://Textures/1/Hover/16.png"),preload("res://Textures/1/Hover/17.png"),preload("res://Textures/1/Hover/18.png")],
[preload("res://Textures/1/Selected/11.png"),preload("res://Textures/1/Selected/12.png"),preload("res://Textures/1/Selected/13.png"),preload("res://Textures/1/Selected/14.png"),preload("res://Textures/1/Selected/15.png"),preload("res://Textures/1/Selected/16.png"),preload("res://Textures/1/Selected/17.png"),preload("res://Textures/1/Selected/18.png")],
[preload("res://Textures/1/pressed/11.png"),preload("res://Textures/1/pressed/12.png"),preload("res://Textures/1/pressed/13.png"),preload("res://Textures/1/pressed/14.png"),preload("res://Textures/1/pressed/15.png"),preload("res://Textures/1/pressed/16.png"),preload("res://Textures/1/pressed/17.png"),preload("res://Textures/1/pressed/18.png")]]
,[[preload("res://Textures/2/Normal/21.png"),preload("res://Textures/2/Normal/22.png"),preload("res://Textures/2/Normal/23.png"),preload("res://Textures/2/Normal/24.png"),preload("res://Textures/2/Normal/25.png"),preload("res://Textures/2/Normal/26.png"),preload("res://Textures/2/Normal/27.png"),preload("res://Textures/2/Normal/28.png")],
[preload("res://Textures/2/Hover/21.png"),preload("res://Textures/2/Hover/22.png"),preload("res://Textures/2/Hover/23.png"),preload("res://Textures/2/Hover/24.png"),preload("res://Textures/2/Hover/25.png"),preload("res://Textures/2/Hover/26.png"),preload("res://Textures/2/Hover/27.png"),preload("res://Textures/2/Hover/28.png")],
[preload("res://Textures/2/Selected/21.png"),preload("res://Textures/2/Selected/22.png"),preload("res://Textures/2/Selected/23.png"),preload("res://Textures/2/Selected/24.png"),preload("res://Textures/2/Selected/25.png"),preload("res://Textures/2/Selected/26.png"),preload("res://Textures/2/Selected/27.png"),preload("res://Textures/2/Selected/28.png")],
[preload("res://Textures/2/pressed/21.png"),preload("res://Textures/2/pressed/22.png"),preload("res://Textures/2/pressed/23.png"),preload("res://Textures/2/pressed/24.png"),preload("res://Textures/2/pressed/25.png"),preload("res://Textures/2/pressed/26.png"),preload("res://Textures/2/pressed/27.png"),preload("res://Textures/2/pressed/28.png")]]
,[[preload("res://Textures/3/Normal/31.png"),preload("res://Textures/3/Normal/32.png"),preload("res://Textures/3/Normal/33.png"),preload("res://Textures/3/Normal/34.png"),preload("res://Textures/3/Normal/35.png"),preload("res://Textures/3/Normal/36.png"),preload("res://Textures/3/Normal/37.png"),preload("res://Textures/3/Normal/38.png")],
[preload("res://Textures/3/Hover/31.png"),preload("res://Textures/3/Hover/32.png"),preload("res://Textures/3/Hover/33.png"),preload("res://Textures/3/Hover/34.png"),preload("res://Textures/3/Hover/35.png"),preload("res://Textures/3/Hover/36.png"),preload("res://Textures/3/Hover/37.png"),preload("res://Textures/3/Hover/38.png")],
[preload("res://Textures/3/Selected/31.png"),preload("res://Textures/3/Selected/32.png"),preload("res://Textures/3/Selected/33.png"),preload("res://Textures/3/Selected/34.png"),preload("res://Textures/3/Selected/35.png"),preload("res://Textures/3/Selected/36.png"),preload("res://Textures/3/Selected/37.png"),preload("res://Textures/3/Selected/38.png")],
[preload("res://Textures/3/pressed/31.png"),preload("res://Textures/3/pressed/32.png"),preload("res://Textures/3/pressed/33.png"),preload("res://Textures/3/pressed/34.png"),preload("res://Textures/3/pressed/35.png"),preload("res://Textures/3/pressed/36.png"),preload("res://Textures/3/pressed/37.png"),preload("res://Textures/3/pressed/38.png")]]
,[[preload("res://Textures/4/Normal/41.png"),preload("res://Textures/4/Normal/42.png"),preload("res://Textures/4/Normal/43.png"),preload("res://Textures/4/Normal/44.png"),preload("res://Textures/4/Normal/45.png"),preload("res://Textures/4/Normal/46.png"),preload("res://Textures/4/Normal/47.png"),preload("res://Textures/4/Normal/48.png")],
[preload("res://Textures/4/Hover/41.png"),preload("res://Textures/4/Hover/42.png"),preload("res://Textures/4/Hover/43.png"),preload("res://Textures/4/Hover/44.png"),preload("res://Textures/4/Hover/45.png"),preload("res://Textures/4/Hover/46.png"),preload("res://Textures/4/Hover/47.png"),preload("res://Textures/4/Hover/48.png")],
[preload("res://Textures/4/Selected/41.png"),preload("res://Textures/4/Selected/42.png"),preload("res://Textures/4/Selected/43.png"),preload("res://Textures/4/Selected/44.png"),preload("res://Textures/4/Selected/45.png"),preload("res://Textures/4/Selected/46.png"),preload("res://Textures/4/Selected/47.png"),preload("res://Textures/4/Selected/48.png")],
[preload("res://Textures/4/pressed/41.png"),preload("res://Textures/4/pressed/42.png"),preload("res://Textures/4/pressed/43.png"),preload("res://Textures/4/pressed/44.png"),preload("res://Textures/4/pressed/45.png"),preload("res://Textures/4/pressed/46.png"),preload("res://Textures/4/pressed/47.png"),preload("res://Textures/4/pressed/48.png")]]
,[[preload("res://Textures/5/Normal/51.png"),preload("res://Textures/5/Normal/52.png"),preload("res://Textures/5/Normal/53.png"),preload("res://Textures/5/Normal/54.png"),preload("res://Textures/5/Normal/55.png"),preload("res://Textures/5/Normal/56.png"),preload("res://Textures/5/Normal/57.png"),preload("res://Textures/5/Normal/58.png")],
[preload("res://Textures/5/Hover/51.png"),preload("res://Textures/5/Hover/52.png"),preload("res://Textures/5/Hover/53.png"),preload("res://Textures/5/Hover/54.png"),preload("res://Textures/5/Hover/55.png"),preload("res://Textures/5/Hover/56.png"),preload("res://Textures/5/Hover/57.png"),preload("res://Textures/5/Hover/58.png")],
[preload("res://Textures/5/Selected/51.png"),preload("res://Textures/5/Selected/52.png"),preload("res://Textures/5/Selected/53.png"),preload("res://Textures/5/Selected/54.png"),preload("res://Textures/5/Selected/55.png"),preload("res://Textures/5/Selected/56.png"),preload("res://Textures/5/Selected/57.png"),preload("res://Textures/5/Selected/58.png")],
[preload("res://Textures/5/pressed/51.png"),preload("res://Textures/5/pressed/52.png"),preload("res://Textures/5/pressed/53.png"),preload("res://Textures/5/pressed/54.png"),preload("res://Textures/5/pressed/55.png"),preload("res://Textures/5/pressed/56.png"),preload("res://Textures/5/pressed/57.png"),preload("res://Textures/5/pressed/58.png")]]
,[[preload("res://Textures/Misc/white.png")],[preload("res://Textures/Misc/white.png")],[preload("res://Textures/Misc/white.png")],[preload("res://Textures/Misc/white.png")]]]

var tmp_dict = {}
#func _ready():
#	get_dictionary()
#	pass

func sol_block_pressed(name, index, id):
	##print("a sol has been clicked", id)
	sol_pos = get_node(name).get_pos()
	sol_index = index
	sol_id = id
	sol_name = name
	sol_clicked += 1
	update_bloc(name, index,id)
	pass
	
func sol_block_shift_pressed(name, index, id):
	##print("a sol has been clicked", id)
	sol_pos = get_node(name).get_pos()
	sol_index = index
	sol_id = id
	sol_name = name
	sol_clicked += 1
	shift_update_bloc(name, index,id)
	pass
	
func update_bloc(name, index,id):
	var cur_id = id
	var new_id = 0
	if cur_id != 49:
		new_id = cur_id + 1
		
	var txt = get_texture(new_id)
	get_node(name).set_id(new_id)
	get_node(name).set_normal_texture(blocs[txt[0]][0][txt[1]])
	
	##print("solution_grid before ", solution_grid)
	solution_grid[index-1][1] = new_id
	##print("solution_grid after ", solution_grid)
	pass

func shift_update_bloc(name, index,id):
	var cur_id = id
	var new_id = 0
	if cur_id <= 39:
		new_id = cur_id + 10
	else:
		 new_id = cur_id - 40
		
	var txt = get_texture(new_id)
	get_node(name).set_id(new_id)
	get_node(name).set_normal_texture(blocs[txt[0]][0][txt[1]])
	
	##print("solution_grid before ", solution_grid)
	solution_grid[index-1][1] = new_id
	##print("solution_grid after ", solution_grid)
	pass

func adjacent():
	var distance = pos1 - pos2
	#print("the distance between the two is ",distance)
	if ((distance.x >= 120 or distance.y >= 120) or (distance.x <= -120 or distance.y <= -120)):
		return 0 
	elif (distance.x == 75 or distance.y == 75 or distance.x == -75 or distance.y == -75):
		return 1
	else:
		return 0

func reset_swap():
	clicked = 0 
	
func combine():
	pass

#  return 0 if the switch is diagonal else return 1
func get_orientation():
	var distance = pos1 - pos2
	if (distance.x == 0 or distance.y == 0) :
		#horizontal or vertical switch
		return 1
	else:
		#diagonal switch 
		return 0

func get_texture(val):
	return textures[val]

func set_sol(sol):
	solution_grid = sol
	
func get_sol():
	return solution_grid

func load_sol_grid():
	for i in solution_grid:
		create_sol_bloc(grid[i[0]],i[0], i[1])
	pass
	
func delete_grid():
	for child in get_children():
		child.queue_free()

func create_sol_bloc(pos,index, id):
	var txt = get_texture(id)
	if id!=-1: 
		bloc = TextureButton.new()
		bloc.set_normal_texture(blocs[txt[0]][0][txt[1]])
		bloc.rect_position = pos - Vector2(405.5,0)
	###print(bloc.get_size/2)
	#bloc.set_offset()
		bloc.set_script(sol_bloc_script)
		bloc.set_index(index)
		bloc.set_id(id)
		add_child(bloc, true)
	pass
	