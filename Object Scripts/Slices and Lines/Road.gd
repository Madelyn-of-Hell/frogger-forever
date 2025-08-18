extends HorizontalLine
class_name Road

func _init(v_pos:int, m_direction:Direction, s_cooldown:float, o_speed:float = 100) -> void:
	name = "Road"
	spawner_object = CarObstacle
	floor_sprite = sprite_sheet.get_frame_texture("default",5)
	var speed_modifier = randf_range(0.5,2)
	Engine.get_main_loop().create_timer(randf_range(0.1,1)).timeout.connect(_road_init_part_2.bind(v_pos,m_direction,s_cooldown, o_speed*speed_modifier))

func _road_init_part_2(v_pos,m_direction,s_cooldown, o_speed):
	super._init(v_pos, m_direction, s_cooldown, o_speed)
