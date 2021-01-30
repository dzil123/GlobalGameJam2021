extends ItemList

var fs = null
var is_running = true

#var folder_tex = preload("res://FolderTex.tres")
var folder_tex = preload("res://folder.png")
var file_tex = preload("res://file.png")
var solution_tex = preload("res://solution.png")

func _ready():
	fs = load("res://Filesystem.gd").generate()
	fs.connect("changed_dir", self, "_on_Filesystem_changed_dir")
	fs.connect("found_solution", self, "_on_Filesystem_found_solution")
	fs.cd_slash()
#	for i in range(10):
#		add_item("testing" + str(i), folder_tex)
	
#	yield(get_tree(), "idle_frame")
	#recalc_path()
	get_node("Timer").start()
	start_random()

func start_random():
	var popup = get_node("../../AcceptDialog")
	
	while is_running:
		var time = rand_range(1.0, 2.0)
		time = 10.0
		print("waiting " + str(time))
		yield(get_tree().create_timer(time), "timeout")
		print("start")
		if not is_running:
			return
		popup.popup()
		yield(popup, "confirmed")
		print("end")
		
		

func _on_ItemList_item_activated(index):
	if not is_running:
		return
	
	print("selected " + str(index))
	
	var new_folder = get_item_text(index)
	fs.cd(new_folder)
	
	#recalc_path()

func _on_Filesystem_found_solution():
	is_running = false
	print("you win!!!!")
	get_node("../../WinDialog").popup()

#func recalc_path():
func _on_Filesystem_changed_dir(path_str: String):
	clear()
	
	#var path_str = root_path + path.join(seperator)
	get_node("../Label").text = path_str
	
#	var this_folder = folders
#	for child_folder in path:
#		this_folder = this_folder[child_folder]
	
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
	
#	print("go up")
#	print(path)
#	path.remove(path.size() - 1)
#	print(path)
#	recalc_path()
	fs.go_up()


func _on_Timer_timeout():
	if not is_running:
		return
	print("timeout")
	is_running = false
	get_node("../../LoseDialog").popup()


func _on_RestartButton_pressed():
	get_tree().change_scene("res://Control.tscn")
