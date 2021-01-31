extends Node

export(String, FILE, "*.txt") var file_name
var text: Array = ["could not load text :("]

func _ready():
	var f = File.new()
	f.open(file_name, File.READ)
	text = f.get_as_text().split("\n", false)
