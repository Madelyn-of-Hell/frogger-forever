extends WorldConstants
class_name GameHandler

var player: Player
var world: Array[HorizontalSlice]
var ui: Control

func create_new_slice():
	print("slicing the pizza 🤌🤌🤌")
	
	# I needs tha last slice to determine wheres to put ze NEW slice 🍕🍕🍕
	var prev_slice = world.back()
	var v_pos = prev_slice.vertical_pos - prev_slice.vertical_length
	var new_slice = HorizontalSlice.new(v_pos, world.size())
	new_slice.position.y = v_pos * grid_step
	world.append(new_slice)
	
	call_deferred("add_child", new_slice)
	cleanup()
	print("World is now ", world.size(), " slices long")

## A relatively untested function for killing old  chunks so you don't gotta deal wit tha memory spikes hopefully 👍
func cleanup():
	if world.size() > 20:
		world[0].queue_free()
		world.remove_at(0)
	print("cleaned")
	
func _on_player_death(score:int):
	var death_panel = preload("res://Scenes/restart.tscn").instantiate()
	death_panel.set_position(Vector2(0,-0.75*grid_step))
	call_deferred("add_child", death_panel)

func _ready() -> void:
	# A little group with just gamehandler so that everyone can yell at it from everywhere. I don't really wanna repeat this trick because it feels like a cheat but at the same time it works and it's super simple so heck you :c
	self.add_to_group("GameHandler")
	
	# Makin' the first slice manually bc it's easier than modifying create_new_slice
	var first_slice = HorizontalSlice.new(0,0,3,HorizontalSlice.SliceType.SafeZone)
	world.append(first_slice)
	add_child(first_slice)
	# Generate starting environment
	for i in 10:
		create_new_slice()

	self.player = Player.new()
	self.player.set_position(Vector2(0,-2* grid_step))
	self.player.target_pos = Vector2(0,-2* grid_step)
	
	# OK so when the game starts, all the objects have just loaded in so there are no objects on the screen. My solution to this is to speed the game up 10x, freeze this thread for a bit while the objects do their thing, then revert it to normal speed and start the game 👍
	var loading_screen = preload("res://Scenes/background.tscn").instantiate()
	add_child(loading_screen)
	Engine.set_time_scale(10)
	await get_tree().create_timer(10.0).timeout
	Engine.set_time_scale(1)
	loading_screen.queue_free()
	add_child(player)
