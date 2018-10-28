extends Node2D

var pos1 
var name1 
var id1
var pos2 
var name2 
var id2
var clicked = 0
var first_id


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

#positions and initial types actually used for problem 
# A block2 (green) at position 2 (1 , 2)
var current_grid = [
[1, 1] , [2, 1] , [3, 1] , [4, 1] , [5, 1] , [6, 1] , [7, 1] ,
[8, 1] , [9, 1] , [10, 1] , [11, 1] , [12, 1] , [13, 1] , [14, 1] ,
[15, 1] , [16, 1] , [17, 1] , [18, 1] , [19, 1] , [20, 1] , [21, 1] ,
[22, 1] , [23, 1] , [24, 1] , [25, 1] , [26, 1] , [27, 1] , [28, 1] ,
[29, 1] , [30, 1] , [31, 1] , [32, 1] , [33, 1] , [34, 1] , [35, 1] ,
[36, 1] , [37, 1] , [38, 1] , [39, 1] , [40, 1] , [41, 1] , [42, 1] ,
[43, 1] , [44, 1] , [45, 1] , [46, 1] , [47, 1] , [48, 1] , [49, 1] ]
#= [[1, 1] , [2, 2] , [3, 2] , [4, 1], [5, 2] , [6, 1] , [7, 1] , [8, 1], [9, 1]]

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
var bloc_script = preload("res://bloc.gd")

#normal, hover,selcted, pressed, 
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
func start():
	load_dict()
	load_grid()



func _block_pressed(name,index, id):
	var txt = get_texture(id)
	#print("something's been clicked", index," ",txt[1])
	if clicked == 0:
		pos1 = get_node(name).rect_position
		id1 = index - 1
		name1 = name
		clicked += 1
		first_id = id
		if txt[1] == 1:
			reset_swap()
		else:
			get_node(name1).set_normal_texture(blocs[txt[0]][2][txt[1]])
	elif clicked == 1:
		pos2= get_node(name).rect_position
		id2 = index - 1
		name2 = name
		var orientation = get_orientation()
		var txt2 = get_texture(first_id)
		get_node(name1).set_normal_texture(blocs[txt2[0]][0][txt2[1]])
		if (txt[1] == 1 ):
			reset_swap()
		elif(txt == txt2):
			reset_swap()
		elif (pos1 == pos2):
			reset_swap()
		elif (adjacent() != 1):
			reset_swap() 
		elif ((txt[1] == 2 or txt2[1] == 2) and orientation == 0):
			reset_swap()
		elif ((txt[1] == 3 or txt2[1] == 3) and orientation == 1):
			reset_swap()
		elif ((txt[1] == 4 and txt2[1] == 5) or (txt2[1] == 4 and txt[1] == 5)):
			combine()
		elif ((txt[1] == 6 and txt2[1] == 7) or (txt2[1] == 6 and txt[1] == 7)):
			combine()
		else: 
			swap()
	else:
        print("error")

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


func load_grid():
	for i in current_grid:
		create_bloc(grid[i[0]],i[0], i[1])
	pass
	
# creates a bloc at a given position with a given id and tyoe (texture)
func create_bloc(pos,index, id):
	var txt = get_texture(id)
	if (txt[0] == 6):
		bloc = TextureButton.new()
		bloc.set_normal_texture(blocs[txt[0]][0][txt[1]])
		bloc.rect_position = (pos - Vector2(25,25))
	###print(bloc.get_size/2)
	#bloc.set_offset()
		bloc.set_script(bloc_script)
		bloc.connect("pressed", bloc, "self_pressed")
		bloc.set_index(index)
		bloc.set_id(id)
		bloc.set_type(txt[1])
		add_child(bloc, true)
	elif (txt[0] != 0): 
		bloc = TextureButton.new()
		bloc.set_normal_texture(blocs[txt[0]][0][txt[1]])
		bloc.set_hover_texture(blocs[txt[0]][1][txt[1]])
		#bloc.set_focused_texture(blocs[txt[0]][2][txt[1]])
		bloc.set_pressed_texture(blocs[txt[0]][3][txt[1]])
		bloc.rect_position = (pos - Vector2(25,25))
	###print(bloc.get_size/2)
	#bloc.set_offset()
		bloc.set_script(bloc_script)
		bloc.connect("pressed", bloc, "self_pressed")
		bloc.set_index(index)
		bloc.set_id(id)
		bloc.set_type(txt[1])
		add_child(bloc, true)
	pass
	
func check_solution():
	if compare_grids() == false:
		#print("not equal")
		if maximum_steps == 0:
			get_parent().fail(steps_so_far)
	else:
		#print("Success. you used ", steps_so_far, " step")
		get_parent().success(steps_so_far)
		
func compare_grids():
	##print("compre_grids recieved ",current_grid, " and " , solution_grid)
	for i in range(current_grid.size()):
		if textures[current_grid[i][1]][0] != textures[solution_grid[i][1]][0]:
			return false
	pass

# swaps the indexes of the two blocks
func swap_id():
	get_node(name1).set_index(id2 + 1)
	get_node(name2).set_index(id1 + 1)

# reflects swap in grid array
func swap_grid_pos():
	#print("grid before swap is", current_grid)
	var bloc1 = current_grid[id1]
	var bloc2 = current_grid[id2]
	current_grid[id2] = bloc1
	current_grid[id1] = bloc2
	#print("grid after swap is",current_grid)
	pass

# swaps blocks on users screen
func swap():
	pos1 = get_node(name1).rect_position
	pos2 = get_node(name2).rect_position
	get_node(name1).rect_position = (pos2)
	get_node(name2).rect_position = (pos1)
	swap_grid_pos()
	swap_id()
	clicked = 0
	steps_so_far += 1
	maximum_steps -= 1
	get_parent().set_count(str(maximum_steps))
	check_solution()
	pass

	
func load_dict():
	tmp_dict = get_parent().get_dictionary()
	#an alternative is current_grid.append(
	current_grid[0] = [1, tmp_dict["cur1"]]
	current_grid[1] = [2, tmp_dict["cur2"]]
	current_grid[2] = [3, tmp_dict["cur3"]]
	current_grid[3] = [4, tmp_dict["cur4"]]
	current_grid[4] = [5, tmp_dict["cur5"]]
	current_grid[5] = [6, tmp_dict["cur6"]]
	current_grid[6] = [7, tmp_dict["cur7"]]
	current_grid[7] = [8, tmp_dict["cur8"]]
	current_grid[8] = [9, tmp_dict["cur9"]]
	current_grid[9] = [10, tmp_dict["cur10"]]
	current_grid[10] = [11, tmp_dict["cur11"]]
	current_grid[11] = [12, tmp_dict["cur12"]]
	current_grid[12] = [13, tmp_dict["cur13"]]
	current_grid[13] = [14, tmp_dict["cur14"]]
	current_grid[14] = [15, tmp_dict["cur15"]]
	current_grid[15] = [16, tmp_dict["cur16"]]
	current_grid[16] = [17, tmp_dict["cur17"]]
	current_grid[17] = [18, tmp_dict["cur18"]]
	current_grid[18] = [19, tmp_dict["cur19"]]
	current_grid[19] = [20, tmp_dict["cur20"]]
	current_grid[20] = [21, tmp_dict["cur21"]]
	current_grid[21] = [22, tmp_dict["cur22"]]
	current_grid[22] = [23, tmp_dict["cur23"]]
	current_grid[23] = [24, tmp_dict["cur24"]]
	current_grid[24] = [25, tmp_dict["cur25"]]
	current_grid[25] = [26, tmp_dict["cur26"]]
	current_grid[26] = [27, tmp_dict["cur27"]]
	current_grid[27] = [28, tmp_dict["cur28"]]
	current_grid[28] = [29, tmp_dict["cur29"]]
	current_grid[29] = [30, tmp_dict["cur30"]]
	current_grid[30] = [31, tmp_dict["cur31"]]
	current_grid[31] = [32, tmp_dict["cur32"]]
	current_grid[32] = [33, tmp_dict["cur33"]]
	current_grid[33] = [34, tmp_dict["cur34"]]
	current_grid[34] = [35, tmp_dict["cur35"]]
	current_grid[35] = [36, tmp_dict["cur36"]]
	current_grid[36] = [37, tmp_dict["cur37"]]
	current_grid[37] = [38, tmp_dict["cur38"]]
	current_grid[38] = [39, tmp_dict["cur39"]]
	current_grid[39] = [40, tmp_dict["cur40"]]
	current_grid[40] = [41, tmp_dict["cur41"]]
	current_grid[41] = [42, tmp_dict["cur42"]]
	current_grid[42] = [43, tmp_dict["cur43"]]
	current_grid[43] = [44, tmp_dict["cur44"]]
	current_grid[44] = [45, tmp_dict["cur45"]]
	current_grid[45] = [46, tmp_dict["cur46"]]
	current_grid[46] = [47, tmp_dict["cur47"]]
	current_grid[47] = [48, tmp_dict["cur48"]]
	current_grid[48] = [49, tmp_dict["cur49"]]
	#print(current_grid)
	
	solution_grid[0] = [1, tmp_dict["sol1"]]
	solution_grid[1] = [2, tmp_dict["sol2"]]
	solution_grid[2] = [3, tmp_dict["sol3"]]
	solution_grid[3] = [4, tmp_dict["sol4"]]
	solution_grid[4] = [5, tmp_dict["sol5"]]
	solution_grid[5] = [6, tmp_dict["sol6"]]
	solution_grid[6] = [7, tmp_dict["sol7"]]
	solution_grid[7] = [8, tmp_dict["sol8"]]
	solution_grid[8] = [9, tmp_dict["sol9"]]
	solution_grid[9] = [10, tmp_dict["sol10"]]
	solution_grid[10] = [11, tmp_dict["sol11"]]
	solution_grid[11] = [12, tmp_dict["sol12"]]
	solution_grid[12] = [13, tmp_dict["sol13"]]
	solution_grid[13] = [14, tmp_dict["sol14"]]
	solution_grid[14] = [15, tmp_dict["sol15"]]
	solution_grid[15] = [16, tmp_dict["sol16"]]
	solution_grid[16] = [17, tmp_dict["sol17"]]
	solution_grid[17] = [18, tmp_dict["sol18"]]
	solution_grid[18] = [19, tmp_dict["sol19"]]
	solution_grid[19] = [20, tmp_dict["sol20"]]
	solution_grid[20] = [21, tmp_dict["sol21"]]
	solution_grid[21] = [22, tmp_dict["sol22"]]
	solution_grid[22] = [23, tmp_dict["sol23"]]
	solution_grid[23] = [24, tmp_dict["sol24"]]
	solution_grid[24] = [25, tmp_dict["sol25"]]
	solution_grid[25] = [26, tmp_dict["sol26"]]
	solution_grid[26] = [27, tmp_dict["sol27"]]
	solution_grid[27] = [28, tmp_dict["sol28"]]
	solution_grid[28] = [29, tmp_dict["sol29"]]
	solution_grid[29] = [30, tmp_dict["sol30"]]
	solution_grid[30] = [31, tmp_dict["sol31"]]
	solution_grid[31] = [32, tmp_dict["sol32"]]
	solution_grid[32] = [33, tmp_dict["sol33"]]
	solution_grid[33] = [34, tmp_dict["sol34"]]
	solution_grid[34] = [35, tmp_dict["sol35"]]
	solution_grid[35] = [36, tmp_dict["sol36"]]
	solution_grid[36] = [37, tmp_dict["sol37"]]
	solution_grid[37] = [38, tmp_dict["sol38"]]
	solution_grid[38] = [39, tmp_dict["sol39"]]
	solution_grid[39] = [40, tmp_dict["sol40"]]
	solution_grid[40] = [41, tmp_dict["sol41"]]
	solution_grid[41] = [42, tmp_dict["sol42"]]
	solution_grid[42] = [43, tmp_dict["sol43"]]
	solution_grid[43] = [44, tmp_dict["sol44"]]
	solution_grid[44] = [45, tmp_dict["sol45"]]
	solution_grid[45] = [46, tmp_dict["sol46"]]
	solution_grid[46] = [47, tmp_dict["sol47"]]
	solution_grid[47] = [48, tmp_dict["sol48"]]
	solution_grid[48] = [49, tmp_dict["sol49"]]
	#print(solution_grid)
	
	level_id = tmp_dict["id"].to_int()
	maximum_steps = tmp_dict["max_moves"].to_int()
	file_path = tmp_dict["file"]
	level_desc =  tmp_dict["desc"]
	optimum_steps = tmp_dict["optimum_steps"]
	steps_so_far = 0
	#sol = tmp_dict["solution_path"]
	
	pass
