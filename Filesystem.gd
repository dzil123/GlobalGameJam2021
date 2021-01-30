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

	func new_folder() -> Folder:
		var folder: Folder = all_folders[randi() % all_folders.size()]
		return folder.add_child_new(random_name())

	func add_rand_folder():
		all_folders.append(new_folder())

	func add_rand_file() -> Folder:
		var new_file := new_folder()
		new_file.set_is_file()
		return new_file

	func generate():
		for i in range(5):
			add_rand_folder()

		for i in range(5):
			add_rand_file()

		add_rand_file().set_is_solution()

		for folder in all_folders:
			folder.children.shuffle()


func generate():
	RandomGenerator.new(root).generate()
