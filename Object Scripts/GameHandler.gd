extends WorldConstants
class_name GameHandler

var player: Player
var world: Array[HorizontalSlice]
var ui: Control

func create_new_slice():
	print("slicing the pizza 🤌🤌🤌")
	var prev_slice = world.back()
	var v_pos = prev_slice.vertical_pos - prev_slice.vertical_length
	#print("New slice pos:", -v_pos)
	var new_slice = HorizontalSlice.new(v_pos, world.size())
	new_slice.position.y = v_pos * grid_step
	world.append(new_slice)
	call_deferred("add_child", new_slice)
	cleanup()
	print(world.size())

func cleanup():
	if world.size() > 20:
		world[-1].queue_free()
		world.remove_at(-1)
	print("cleaned")
func _on_player_death(score:int):
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
	self.add_to_group("GameHandler")
	var first_slice = HorizontalSlice.new(0,0,3,HorizontalSlice.SliceType.SafeZone)
	world.append(first_slice)
	add_child(first_slice)
	for i in 10:
		create_new_slice()
	self.player = Player.new()
	self.player.set_position(Vector2(0,-2* grid_step))
	self.player.target_pos = Vector2(0,-2* grid_step)
	Engine.set_time_scale(10)
	await get_tree().create_timer(10.0).timeout
	Engine.set_time_scale(1)
	add_child(player)
