extends Control
onready var GameManager = get_node(@"/root/GameManager")

func _ready():
	var level_text = "[center]Current Level: %s[/center]" % GameManager.get_level_name(-1, true)
	get_node(@"CurrentLevelLabel").bbcode_text = level_text
	
	create_level_select()


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_PlayButton_pressed():
	GameManager.load_game_scene()


func create_level_select():
	var menu = get_node(@"LevelSelectPopup")
	for level in GameManager.all_levels():
		menu.add_item(level)


func _on_LevelSelectButton_pressed():
	get_node(@"LevelSelectPopup").popup()


func _on_LevelSelectPopup_index_pressed(index):
	GameManager.current_level = index
	_on_PlayButton_pressed()
