extends Control

signal unlocked

const FORMAT_STR = """
This is the sample Virus popup text
Do not press the button or u will die
%.1fs
"""

var time_to_wait = 3.0

func _ready():
	get_node(@"Timer").start(time_to_wait)
#	_process(0)
	yield(get_tree(), "idle_frame")
	get_node(@"Button").grab_focus()

func _process(_delta):
	get_node(@"Label").text = FORMAT_STR % get_node("Timer").time_left

func _on_Timer_timeout():
	emit_signal("unlocked")


func _on_Button_pressed():
	time_to_wait *= 1.5
	_ready()
