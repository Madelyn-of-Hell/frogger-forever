extends Button
# Litrlly just connects the button
func _ready():
	self.button_up.connect(get_node('/root/WorldController')._change_scene.bind(load("res://Scenes/game_handler.tscn")))
