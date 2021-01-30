extends Resource

# class_name Filesystem

signal changed_dir(name)
signal found_solution

const seperator = "\\"
const root_path = "C:" + seperator

var path = PoolStringArray()
var root = null

static func create_new():
	var fs = load("res://Filesystem.gd").new()
	fs.root = preload("res://Folder.gd").new()
	fs.root.name = seperator
	return fs

#func curdir() -> Folder:
func curdir():
	var folder = root
	for name in path:
		folder = folder.get_child(name)
	return folder

func pwd() -> String:
	return root_path + path.join(seperator)

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

func _on_changed():
	emit_signal("changed_dir", pwd())

func _on_solution():
	emit_signal("found_solution")

static func random_name():
	var alphabet = "qwertyuiopasdfghjklzxcvbnm       "
	var name = ""
		
	for index in range(5 + randi() % 10):
		var i = randi() % alphabet.length()
		name += alphabet[i]
	
	return name

static func add_rand_folder(all_folders: Array):
	var folder = all_folders[randi() % all_folders.size()]
	var new_folder = folder.add_child_new(random_name())
	all_folders.append(new_folder)

static func add_rand_file(all_folders: Array):
	var folder = all_folders[randi() % all_folders.size()]
	var new_file = folder.add_child_new(random_name())
	new_file.set_is_file()
	return new_file

static func generate():
	
	randomize()
	var seeed = randi()
	
	#var seeed = 10
	
	print("Running seed = " + str(seeed))
	seed(seeed)
	
	var fs = create_new()
	var all_folders = [fs.root]
	
	for i in range(5):
		add_rand_folder(all_folders)
	
	for i in range(5):
		add_rand_file(all_folders)
	
	add_rand_file(all_folders).set_is_solution()
	
	for folder in all_folders:
		folder.children.shuffle()
	
	return fs
