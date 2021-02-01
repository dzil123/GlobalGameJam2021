extends Node

export (PackedScene) var start_menu_scene
export (PackedScene) var game_scene
export (Array, Resource) var levels  # Level
export (int) var current_level = 0

# usage: get_node(@"/root/GameManager").load_some_scene()


func load_scene(scene: PackedScene):
	get_node(@"MusicPlayer").pitch_scale = 1
	get_tree().change_scene_to(scene)


func load_game_scene():
#	get_node(@"MusicPlayer").stream_paused = false
	load_scene(game_scene)


func load_menu_scene():
#	get_node(@"MusicPlayer").stream_paused = true
	load_scene(start_menu_scene)


func get_level() -> Level:
	return levels[current_level]


func get_level_name(level: int = -1, short: bool = false) -> String:
	if level < 0:
		level = current_level
	if level == levels.size() - 1:
		return "Free Play"
	if short:
		return "%d" % level
	return "Level: %d" % level


func next_level():
	current_level = min(current_level + 1, levels.size() - 1)
	load_game_scene()


func all_levels() -> Array:
	var arr = []
	for level in range(levels.size()):
		arr.append(get_level_name(level))
	return arr


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_node(@"ClickPlayer").play()
