extends Node2D
class_name WorldController

var current_scene:PackedScene = preload("res://main_menu.tscn")

func _ready():
	add_child(current_scene.instantiate())

func _change_scene(new_scene: PackedScene):
	current_scene = new_scene
	get_children().map(func(child): child.queue_free())
	add_child(current_scene.instantiate())
