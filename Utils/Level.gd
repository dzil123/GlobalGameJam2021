class_name Level

extends Resource

export (float) var time = 10
export (int) var num_folders = 10
export (int) var num_files = 5
export (int) var min_folder_depth = -1
export (int) var max_folder_depth = -1
export (int) var min_file_depth = -1
export (int) var max_file_depth = -1
export (int) var min_solution_depth = -1
export (int, FLAGS, "Password", "Alert", "Virus", "Counting") var blacklist = 0
export (Resource) var preset_folder  # Folder

var all_folders = null


func allowed_popups(popups: Array) -> Array:
	var new_popups = []
	for i in range(popups.size()):
		if not blacklist & (1 << i):
			new_popups.append(popups[i])
	return new_popups


static func random_name() -> String:
	var alphabet := "abcdefghijklmnopqrstuvwxyz     "
	var name := ""

	for index in range(5 + randi() % 10):
		var i = randi() % alphabet.length()
		name += alphabet[i]

	return name


func _new_folder_test(folder: Folder, depth_max: int, depth_min: int):
	if folder == null:
		return true
	if depth_max >= 0 and folder.depth > depth_max:
		return true
	if depth_min >= 0 and folder.depth < depth_min:
		return true
	return false


func new_folder(depth_max: int = -1, depth_min: int = -1) -> Folder:
	var folder: Folder = null
	while _new_folder_test(folder, depth_max, depth_min):
		folder = all_folders[randi() % all_folders.size()]
	return folder.add_child_new(random_name())


func add_rand_folder(depth_max: int = -1, depth_min: int = -1):
	all_folders.append(new_folder(depth_max, depth_min))


func add_rand_file(depth_max: int, depth_min: int = -1) -> Folder:
	var new_file := new_folder(depth_max, depth_min)
	new_file.set_is_file()
	return new_file


func generate() -> Filesystem:
	var fs = Filesystem.new()

	if preset_folder != null:
		var x = preset_folder.copy()
		fs.root = x
	fs.root.set_depth(0)
	all_folders = fs.find()

	for i in range(num_folders):
		add_rand_folder(max_folder_depth, min_folder_depth)

	for i in range(num_files):
		add_rand_file(max_file_depth, min_file_depth)

	add_rand_file(-1, min_solution_depth).set_is_solution()

	for folder in all_folders:
		folder.children.shuffle()

	all_folders = null

	return fs
