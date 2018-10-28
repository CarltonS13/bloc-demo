extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var id = 0
var index = 0 
var type

func _ready():
	pass

func _input_event(ev):
    if (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed and not(ev.shift)):
        get_parent().sol_block_pressed(get_name(), index, id)
    elif (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed and ev.shift):
        get_parent().sol_block_shift_pressed(get_name(), index, id)

func set_id(val):
	id = val
	pass
	
func get_id():
	return id
	
func set_index(val):
	index = val
	pass
	
func get_index():
	return index

func set_type(val):
	type = val
	pass
	
func get_type():
	return type