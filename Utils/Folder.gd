class_name Folder

extends Resource

export (String) var name
export (Array, Resource) var children  # Array[Folder]
export (bool) var is_folder = true
export (bool) var is_solution = false
var depth = 0


func get_child(child_name: String) -> Folder:
	if not is_folder:
		return null

	for child in children:
		if child.name == child_name:
			return child

	return null


func add_child(child: Folder):
	if not is_folder:
		push_error("Tried to add child to file")
		return null

	children.append(child)
	child.depth = depth + 1
	return child


func add_child_new(child_name: String):
	var child = load(get_script().resource_path).new()
	child.name = child_name

	return add_child(child)


func set_is_file():
	is_folder = false


func set_is_solution():
	set_is_file()
	is_solution = true


func set_depth(new_depth):
	depth = new_depth
	for child in children:
		child.set_depth(new_depth + 1)


func copy() -> Folder:
	var new_folder = duplicate()
	new_folder.children = []
	for child in children:
		new_folder.children.append(child.copy())
	return new_folder
