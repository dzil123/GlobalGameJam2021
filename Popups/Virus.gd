extends Control

signal unlocked

const FORMAT_STR = """
%s
%.1fs
"""

const VARIANTS = [
	"CLICK NOW OR YOUR SPECIAL\nOFFER WILL GO AWAY",
	"CLICK CLICK CLICK CLICK\nCLICK CLICK CLICK CLICK",
	"My Nigerian Royal Family\nneeds your help!"
]

var chosen_text: String
var time_to_wait = 3.0


func _ready():
	chosen_text = VARIANTS[randi() % VARIANTS.size()]
	get_node(@"Timer").start(time_to_wait)
#	_process(0)
	yield(get_tree(), "idle_frame")
	get_node(@"Button").grab_focus()


func _process(_delta):
	var text = FORMAT_STR % [chosen_text, get_node("Timer").time_left]
	get_node(@"Label").text = text


func _on_Timer_timeout():
	emit_signal("unlocked")


func _on_Button_pressed():
	time_to_wait *= 1.5
	_ready()
