extends Label


func _process(_delta):
	var itemlist = get_node(@"../../ItemList")
	if itemlist.is_running:
		var time = itemlist.get_node(@"Timer").time_left
#		text = "Time left: %.1fs" % time
		text = "%.1fs" % time
