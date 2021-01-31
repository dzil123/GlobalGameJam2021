extends Control


func _init():
	set_rng()

func _ready():
	start_rand_sound()

func set_rng():
	randomize()
	var seeed = randi()

	print("Running seed = %d" % seeed)
	seed(seeed)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_node(@"ClickPlayer").play()

func delay(min_time, max_time):
	var time = rand_range(min_time, max_time)
	print("waiting %.1f" % time)
	return get_tree().create_timer(time)


func start_rand_sound():
	while true:
		yield(delay(0.5, 1.0), "timeout")
		
		var pitch = 1.0		
		if get_node("Panel/ItemList").is_running:
			pitch = rand_range(0.5, 1.5)
		get_node(@"MusicPlayer").pitch_scale = pitch
