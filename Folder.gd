extends Object

# class_name Folder

export var name: String
export var children: Array
export var is_folder: bool = true
export var is_solution: bool = false

#func get_child(child_name: String) -> Folder:
func get_child(child_name: String):
	if not is_folder:
		return null
	
	for child in children:
		if child.name == child_name:
			return child
	
	return null

#func add_child(child: Folder):
func add_child(child):
	if not is_folder:
		return null
	children.append(child)

func add_child_new(child_name: String):
	if not is_folder:
		return null
	
	var child = load("res://Folder.gd").new()
	child.name = child_name
	add_child(child)
	return child

func set_is_file():
	is_folder = false

func set_is_solution():
	set_is_file()
	is_solution = true
