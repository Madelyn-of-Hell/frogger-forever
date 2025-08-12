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
	print(world.size())

## A relatively untested function for killing old  chunks so you don't gotta deal wit tha memory spikes hopefully 👍
func cleanup():
	if world.size() > 20:
		world[-1].queue_free()
		world.remove_at(-1)
	print("cleaned")
	
func _on_player_death(score:int):
	# Make a restart label
	print("Player Died")
	print("Player Score:", score)
	var deathlabel = Label.new()
	deathlabel.set_text("You Died!\nScore: %s" % score)
	deathlabel.set_position(Vector2(0,score*-grid_step))
	var reset_button = Button.new()
	reset_button.set_text("restart")
	reset_button.set_position(Vector2(0,-0.75*grid_step))
	deathlabel.add_child(reset_button)
	reset_button.button_up.connect(get_node('/root/WorldController')._change_scene.bind(preload("res://Scenes/game_handler.tscn")))
	deathlabel.set_horizontal_alignment(HORIZONTAL_ALIGNMENT_CENTER)
	deathlabel.set_scale(Vector2(3,3))
	

	deathlabel.add_child(Camera2D.new())
	self.add_child(deathlabel)

func _ready() -> void:
	# A little group with just gamehandler so that everyone can yell at it from everywhere. I don't really wanna repeat this trick because it feels like a cheat but at the same time it works and it's super simple so heck you :c
	self.add_to_group("GameHandler")
	
	# Makin' the first slice manually bc it's easier than modifying create_new_slice
	var first_slice = HorizontalSlice.new(0,0,5,HorizontalSlice.SliceType.SafeZone)
	world.append(first_slice)
	add_child(first_slice)
	# Generate starting environment
	for i in 10:
		create_new_slice()

	self.player = Player.new()
	self.player.set_position(Vector2(0,-2* grid_step))
	self.player.target_pos = Vector2(0,-2* grid_step)
	
	# OK so when the game starts, all the objects have just loaded in so there are no objects on the screen. My solution to this is to speed the game up 10x, freeze this thread for a bit while the objects do their thing, then revert it to normal speed and start the game 👍
	Engine.set_time_scale(10)
	await get_tree().create_timer(10.0).timeout
	Engine.set_time_scale(1)
	
	add_child(player)
