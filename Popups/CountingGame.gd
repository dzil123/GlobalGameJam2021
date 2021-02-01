extends Control

signal unlocked

const FORMAT_STR = """Click OK when the number is at 10
%.1f"""
const MAX_TIME = 30

func _ready():
	reset_timer()
	yield(get_tree(), "idle_frame")
	get_node("Button").grab_focus()

func reset_timer():
	get_node(@"Timer").start(MAX_TIME)

func get_time() -> float:
	var time = get_node(@"Timer").time_left
	time = 30 - time
	time *= 4
	return time

func _process(_delta):
	get_node(@"Label").text = FORMAT_STR % get_time()

func _on_Button_pressed():
#	if abs(get_time() - 10.15) < 0.35:
	if abs(get_time() - 10) < 0.5:
		emit_signal("unlocked")
	else:
		reset_timer()
