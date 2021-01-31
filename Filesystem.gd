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


func _on_changed():
	emit_signal("changed_dir", pwd())


func _on_solution():
	emit_signal("found_solution")


class RandomGenerator:
	var all_folders: Array  # Array[Folder]

	func _init(root: Folder):
		all_folders = [root]

	static func random_name() -> String:
		var alphabet := "abcdefghijklmnopqrstuvwxyz     "
		var name := ""

		for index in range(5 + randi() % 10):
			var i = randi() % alphabet.length()
			name += alphabet[i]

		return name

	func new_folder(depth_max: int, depth_min: int = -1) -> Folder:
		var folder: Folder = null
		while folder == null or folder.depth > depth_max or folder.depth < depth_min:
			folder = all_folders[randi() % all_folders.size()]
		return folder.add_child_new(random_name())

	func add_rand_folder(depth_max: int, depth_min: int = -1):
		all_folders.append(new_folder(depth_max, depth_min))

	func add_rand_file(depth_max: int, depth_min: int = -1) -> Folder:
		var new_file := new_folder(depth_max, depth_min)
		new_file.set_is_file()
		return new_file

	func generate():
		for i in range(100):
			add_rand_folder(1)

		for i in range(20):
			add_rand_file(3)

		add_rand_file(2, 2).set_is_solution()

		for folder in all_folders:
			folder.children.shuffle()


func generate():
	RandomGenerator.new(root).generate()
