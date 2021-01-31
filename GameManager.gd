extends Node

export (PackedScene) var start_menu_scene
export (PackedScene) var game_scene

# usage: get_node(@"/root/GameManager").load_some_scene()


func load_scene(scene: PackedScene):
	get_node(@"MusicPlayer").pitch_scale = 1
	get_tree().change_scene_to(scene)


func load_game_scene():
	load_scene(game_scene)


func load_menu_scene():
	load_scene(start_menu_scene)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			get_node(@"ClickPlayer").play()
