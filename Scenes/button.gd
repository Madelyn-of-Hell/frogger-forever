extends Button

func _ready():
	button_up.connect(get_node('/root/WorldController')._change_scene.bind(preload("res://Scenes/game_handler.tscn")))
