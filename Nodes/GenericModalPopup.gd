extends WindowDialog


func run(packed_child: PackedScene, attach_to: Node):
	attach_to.add_child(self)
	get_close_button().visible = false

	var child = packed_child.instance()
	get_node("Container").add_child(child)

	var coords = Vector2(50 + randi() % 900, 70 + randi() % 420)
	rect_position = coords

	popup()

	yield(child, "unlocked")
	queue_free()
