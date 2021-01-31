extends Control


func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _on_QuitButton_pressed():
	get_tree().quit()


func _on_PlayButton_pressed():
	get_node(@"/root/GameManager").load_game_scene()
