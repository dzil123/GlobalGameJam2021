extends Control

signal unlocked

func _ready():
	yield(get_tree(), "idle_frame")
	get_node("Button").grab_focus()


func _on_Button_pressed():
	emit_signal("unlocked")
