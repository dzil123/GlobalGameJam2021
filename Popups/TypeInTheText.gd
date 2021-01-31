extends Control

signal unlocked

const FORMAT_STR = """
Computer Locked!
Unlock password: %s
"""

onready var password = generate_password()


func _ready():
	get_node(@"Label").text = FORMAT_STR.strip_edges() % password
	yield(get_tree(), "idle_frame")
	get_node(@"LineEdit").grab_focus()


func _on_LineEdit_input(new_text):
	if new_text == password:
		emit_signal("unlocked")


func generate_password():
	var arr = get_node(@"PasswordReader").text
	return arr[randi() % arr.size()]
