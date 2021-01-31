extends WindowDialog


func run(packed_child: PackedScene, attach_to: Node):
	attach_to.add_child(self)
	get_close_button().disabled = true

	var child = packed_child.instance()
	get_node("Container").add_child(child)

	var coords = Vector2(50 + randi() % 800, 50 + randi() % 600)
#	margin_left = coords.x
#	margin_top = coords.y
	rect_position = coords

	popup()

#	yield(get_tree(), "idle_frame")

	#set_as_minsize()

	yield(child, "unlocked")
	queue_free()
