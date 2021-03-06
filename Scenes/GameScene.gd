extends Control

onready var GameManager = get_node(@"/root/GameManager")


func _init():
	set_rng()


func _ready():
	start_rand_sound()
	get_node(@"Panel").popup_centered()
	get_node(@"Panel").get_close_button().visible = false
	get_node(@"WinDialog").get_ok().text = "Next Level"
	get_node(@"LoseDialog").get_ok().text = "Try Again"


func set_rng():
	randomize()
	var seeed = randi()

	print("Running seed = %d" % seeed)
	seed(seeed)


func delay(min_time, max_time):
	var time = rand_range(min_time, max_time)
	return get_tree().create_timer(time)


func start_rand_sound():
	while true:
		yield(delay(1.0, 2.0), "timeout")

		var pitch = 1.0
		if get_node("Panel/ItemList").is_running:
			pitch = rand_range(0.8, 1.2)
		get_node(@"/root/GameManager/MusicPlayer").pitch_scale = pitch


func restart():
	GameManager.load_game_scene()


func exit():
	GameManager.load_menu_scene()


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			exit()


func win():
	GameManager.next_level()
