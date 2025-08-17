extends Node2D
class_name WorldController

## The current scene. Default, for obvious reasons, is the main menu.
var current_scene:PackedScene = preload("res://Scenes/main_menu.tscn")

func _ready():
	
	add_child(current_scene.instantiate())

func _change_scene(new_scene: PackedScene):
	print(new_scene)
	self.current_scene = new_scene
	# Kill all the children, then spawn the new scene as a child. im killing all the children because I suspect that at some point i'm gonna do something *deeply* weird and end up with multiple children.
	get_children().map(func(child): child.queue_free())
	add_child(current_scene.instantiate())
