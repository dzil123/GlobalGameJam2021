extends WindowDialog


func run(packed_child: PackedScene, attach_to: Node):
	attach_to.add_child(self)
	get_close_button().disabled = true

	var child = packed_child.instance()
	get_node("Container").add_child(child)

	popup()

	yield(child, "unlocked")
	queue_free()
