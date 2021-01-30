extends Control


func _init():
	set_rng()


func set_rng():
	randomize()
	var seeed = randi()

	print("Running seed = %d" % seeed)
	seed(seeed)
