extends Label

func _process(_delta):
	if get_node("../ItemList").is_running:
		var time = get_node("../ItemList/Timer").time_left
		text = "Time left: " + str(time) + "s"
