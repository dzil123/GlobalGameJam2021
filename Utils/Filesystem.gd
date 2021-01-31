class_name Filesystem

extends Resource

signal changed_dir(name)
signal found_solution

const SEPERATOR = "\\"
const ROOT = "C:" + SEPERATOR

export (Resource) var root = Folder.new()

var path = PoolStringArray()


func curdir() -> Folder:
	var folder = root
	for name in path:
		folder = folder.get_child(name)
	return folder


func pwd() -> String:
	return ROOT + path.join(SEPERATOR)


func cd(name: String):
	var new_item = curdir().get_child(name)
	if new_item.is_folder:
		path.append(name)
		_on_changed()
	elif new_item.is_solution:
		_on_solution()


func go_up():
	path.remove(path.size() - 1)
	_on_changed()


func cd_slash():
	path = PoolStringArray()
	_on_changed()


func _find(arr: Array, folder: Folder):
	arr.append(folder)
	for child in folder.children:
		if child.is_folder:
			_find(arr, child)


func find() -> Array:
	var arr = []
	_find(arr, root)
	return arr


func _on_changed():
	emit_signal("changed_dir", pwd())


func _on_solution():
	emit_signal("found_solution")
