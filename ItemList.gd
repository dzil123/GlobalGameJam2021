extends ItemList

export (Resource) var fs
export (PackedScene) var GenericModalPopup

export (Texture) var folder_tex
export (Texture) var file_tex
export (Texture) var solution_tex
export (Texture) var empty_tex

export (Array, PackedScene) var popups

var is_running = true


func _ready():
	fs = Filesystem.new()
	fs.generate()
	fs.connect("changed_dir", self, "_on_Filesystem_changed_dir")
	fs.connect("found_solution", self, "_on_Filesystem_found_solution")
	fs.cd_slash()

	get_node(@"Timer").start()
	start_random()


func delay(min_time, max_time):
	var time = rand_range(min_time, max_time)
	print("waiting %.1f" % time)
	return get_tree().create_timer(time)


func start_random():
#	return
	yield(delay(0.5, 1.0), "timeout")

	while is_running:
		yield(new_dialog(), "completed")
		yield(delay(4.0, 10.0), "timeout")


func new_dialog():
	var popup = popups[randi() % popups.size()]
	var where_to_attach = get_node(@"../..")
	return GenericModalPopup.instance().run(popup, where_to_attach)


func _on_ItemList_item_activated(index):
	if not is_running:
		return

	print("selected %d" % index)

	var new_folder = get_item_text(index)
	if new_folder == "":
		return

	fs.cd(new_folder)


func _on_Filesystem_found_solution():
	is_running = false
	print("you win!!!!")
	get_node(@"../../WinDialog").popup()


#	yield(delay(1.0, 1.0), "timeout")
#	get_node(@"../../WinDialog").popup_exclusive = false


func _on_Filesystem_changed_dir(path_str: String):
	get_node(@"../UpButton").visible = not fs.path.empty()

	clear()

	get_node(@"../Label").text = path_str

	var this_folder = fs.curdir()

	for child in this_folder.children:
		var tex
		if child.is_folder:
			tex = folder_tex
		elif child.is_solution:
			tex = solution_tex
		else:
			tex = file_tex
		add_item(child.name, tex)


func _on_TextureButton_pressed():
	if not is_running:
		return

	fs.go_up()


func _on_Timer_timeout():
	if not is_running:
		return
	print("timeout")
	is_running = false
	get_node(@"../../LoseDialog").popup()
#	yield(delay(1.0, 1.0), "timeout")
#	get_node(@"../../LoseDialog").popup_exclusive = false
