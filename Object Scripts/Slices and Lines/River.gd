extends HorizontalLine
class_name River

func _init(v_pos:int, m_direction:Direction, s_cooldown:float, o_speed:float = 100) -> void:
	name = "River"
	spawner_object = LogObstacle
	floor_sprite = sprite_sheet.get_frame_texture("default", 6)
	var speed_modifier = randf_range(0.7,1.3)
	# praise be to the gorgeous deity u/kleonc for telling me i could do this
	Engine.get_main_loop().create_timer(randf_range(0.1,1)).timeout.connect(_river_init_part_2.bind(v_pos,m_direction,s_cooldown, o_speed*speed_modifier))


func _river_init_part_2(v_pos:int, m_direction:Direction, s_cooldown:float, o_speed:float):
	super._init(v_pos, m_direction, s_cooldown, o_speed)
