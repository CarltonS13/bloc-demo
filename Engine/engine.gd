extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

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

#positions and initial types actually used for problem 
# A block2 (green) at position 2 (1 , 2)
var current_grid = [
[1, 0] , [2, 0] , [3, 0] , [4, 0] , [5, 0] , [6, 0] , [7, 0] ,
[8, 0] , [9, 0] , [10, 0] , [11, 0] , [12, 0] , [13, 0] , [14, 0] ,
[15, 0] , [16, 0] , [17, 0] , [18, 0] , [19, 0] , [20, 0] , [21, 0] ,
[22, 0] , [23, 0] , [24, 0] , [25, 0] , [26, 0] , [27, 0] , [28, 0] ,
[29, 0] , [30, 0] , [31, 0] , [32, 0] , [33, 0] , [34, 0] , [35, 0] ,
[36, 0] , [37, 0] , [38, 0] , [39, 0] , [40, 0] , [41, 0] , [42, 0] ,
[43, 0] , [44, 0] , [45, 0] , [46, 0] , [47, 0] , [48, 0] , [49, 0] ]
 
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

var tmp_dict = {}
#func _ready():
#	get_dictionary()
#	pass
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func refresh_all_grids():
	get_node("sol_grid").delete_grid()
	load_sol_grid()
	get_node("the_grid").delete_grid()
	load_cur_grid()

func load_dictionary():
	tmp_dict = get_parent().get_dictionary()
	if tmp_dict != {}:
		load_dict()
	



#gets id from text input and sets it us id for the currently selected bloc
func set_id():
	pass

func get_texture(val):
	return textures[val]
		
func load_sol_grid():
	get_node("sol_grid").set_sol(solution_grid)
	get_node("sol_grid").load_sol_grid()
	pass
	
func load_cur_grid():
	get_node("the_grid").set_cur(current_grid)
	get_node("the_grid").load_cur_grid()
	pass

func save_level():
	solution_grid = get_node("sol_grid").get_sol()
	current_grid = get_node("the_grid").get_cur()
	
	level_id = get_node("level id").get_text()
	maximum_steps = get_node("max moves").get_text()
	file_path = get_node("dir path").get_text()
	level_desc = get_node("level description").get_text()
	
	var save_dict = {
	#current_grid =  current_grid,
	cur1 = current_grid[0][1],
	cur2 = current_grid[1][1],
	cur3 = current_grid[2][1],
	cur4 = current_grid[3][1],
	cur5 = current_grid[4][1],
	cur6 = current_grid[5][1],
	cur7 = current_grid[6][1],
	cur8 = current_grid[7][1],
	cur9 = current_grid[8][1],
	cur10 = current_grid[9][1],
	cur11 = current_grid[10][1],
	cur12 = current_grid[11][1],
	cur13 = current_grid[12][1],
	cur14 = current_grid[13][1],
	cur15 = current_grid[14][1],
	cur16 = current_grid[15][1],
	cur17 = current_grid[16][1],
	cur18 = current_grid[17][1],
	cur19 = current_grid[18][1],
	cur20 = current_grid[19][1],
	cur21 = current_grid[20][1],
	cur22 = current_grid[21][1],
	cur23 = current_grid[22][1],
	cur24 = current_grid[23][1],
	cur25 = current_grid[24][1],
	cur26 = current_grid[25][1],
	cur27 = current_grid[26][1],
	cur28 = current_grid[27][1],
	cur29 = current_grid[28][1],
	cur30 = current_grid[29][1],
	cur31 = current_grid[30][1],
	cur32 = current_grid[31][1],
	cur33 = current_grid[32][1],
	cur34 = current_grid[33][1],
	cur35 = current_grid[34][1],
	cur36 = current_grid[35][1],
	cur37 = current_grid[36][1],
	cur38 = current_grid[37][1],
	cur39 = current_grid[38][1],
	cur40 = current_grid[39][1],
	cur41 = current_grid[40][1],
	cur42 = current_grid[41][1],
	cur43 = current_grid[42][1],
	cur44 = current_grid[43][1],
	cur45 = current_grid[44][1],
	cur46 = current_grid[45][1],
	cur47 = current_grid[46][1],
	cur48 = current_grid[47][1],
	cur49 = current_grid[48][1],

	#solution_grid = solution_grid, 
	sol1 = solution_grid[0][1],
	sol2 = solution_grid[1][1],
	sol3 = solution_grid[2][1],
	sol4 = solution_grid[3][1],
	sol5 = solution_grid[4][1],
	sol6 = solution_grid[5][1],
	sol7 = solution_grid[6][1],
	sol8 = solution_grid[7][1],
	sol9 = solution_grid[8][1],
	sol10 = solution_grid[9][1],
	sol11 = solution_grid[10][1],
	sol12 = solution_grid[11][1],
	sol13 = solution_grid[12][1],
	sol14 = solution_grid[13][1],
	sol15 = solution_grid[14][1],
	sol16 = solution_grid[15][1],
	sol17 = solution_grid[16][1],
	sol18 = solution_grid[17][1],
	sol19 = solution_grid[18][1],
	sol20 = solution_grid[19][1],
	sol21 = solution_grid[20][1],
	sol22 = solution_grid[21][1],
	sol23 = solution_grid[22][1],
	sol24 = solution_grid[23][1],
	sol25 = solution_grid[24][1],
	sol26 = solution_grid[25][1],
	sol27 = solution_grid[26][1],
	sol28 = solution_grid[27][1],
	sol29 = solution_grid[28][1],
	sol30 = solution_grid[29][1],
	sol31 = solution_grid[30][1],
	sol32 = solution_grid[31][1],
	sol33 = solution_grid[32][1],
	sol34 = solution_grid[33][1],
	sol35 = solution_grid[34][1],
	sol36 = solution_grid[35][1],
	sol37 = solution_grid[36][1],
	sol38 = solution_grid[37][1],
	sol39 = solution_grid[38][1],
	sol40 = solution_grid[39][1],
	sol41 = solution_grid[40][1],
	sol42 = solution_grid[41][1],
	sol43 = solution_grid[42][1],
	sol44 = solution_grid[43][1],
	sol45 = solution_grid[44][1],
	sol46 = solution_grid[45][1],
	sol47 = solution_grid[46][1],
	sol48 = solution_grid[47][1],
	sol49 = solution_grid[48][1],
	
	solution_path = sol,
	id = level_id,
	max_moves = maximum_steps,
	file= file_path,
	desc = level_desc,
	optimum_steps = steps_so_far
	}
	
	var savelevel = File.new()
	savelevel.open(file_path, File.WRITE)
	savelevel.store_string(save_dict.to_json())
	savelevel.close()
	##print("stored ", save_dict.to_json())
	pass

#copy solution grid to current grid
func matchGrid():
	current_grid = solution_grid
	get_node("the_grid").delete_grid()
	load_cur_grid()
	pass

func _on_match_pressed():
	matchGrid()
	pass


func _on_save_pressed():
	save_level()


func _on_load_pressed():
	get_node("load path").popup()
	pass # replace with function body


func _on_dir_open_pressed():
	get_node("save path").popup()
	pass # replace with function body


func _on_load_path_file_selected( path ):
	load_level(path)
	pass # replace with function body


func load_level(path_to_json):
	#"res://initlevel.json"
	var savelevel = File.new()
	if !savelevel.file_exists(path_to_json):
		pritn("error")
		return #Error!  We don't have a level to load
	savelevel.open(path_to_json, File.READ)
	tmp_dict=parse_json(savelevel.get_as_text())
	savelevel.close()
	##print("saved ", tmp_dict)
	load_dict()
	###print(grid)
	refresh_all_grids()
	pass
	
func load_dict():
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
	##print(current_grid)
	
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
	##print(solution_grid)
	
	level_id = tmp_dict["id"]
	maximum_steps = tmp_dict["max_moves"]
	file_path = tmp_dict["file"]
	level_desc =  tmp_dict["desc"]
	optimum_steps = tmp_dict["optimum_steps"]
	steps_so_far = 0
	sol = tmp_dict["solution_path"]
	
	get_node("level description").set_text(level_desc)
	get_node("level id").set_text(level_id)
	get_node("max moves").set_text(maximum_steps)
	get_node("dir path").set_text(file_path)
	get_node("sol").set_text(sol)
	
	pass



func _on_grid_pressed():
	load_sol_grid()
	pass # replace with function body


func _on_save_path_file_selected( path ):
	get_node("dir path").set_text(path)
	pass # replace with function body


func _on_select_solution_file_selected( path ):
	sol = path 
	get_node("sol").set_text(path)
	pass # replace with function body


func _on_sol_enter_pressed():
	get_node("select solution").popup()
	pass # replace with function body


func _on_reset_pressed():
	get_node("the_grid").reset_counter()
	get_node("moves").set_text(str(steps_so_far))
	pass # replace with function body
