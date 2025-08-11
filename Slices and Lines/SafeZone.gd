extends HorizontalLine
class_name SafeZone

func _init(v_pos:int, m_direction:Direction, s_cooldown:float, o_speed:float = 100) -> void:
	name = "SafeZone"
	spawner_object = null
	floor_sprite = preload("res://Assets/SafeZone.png")
	
	super._init(v_pos, m_direction, s_cooldown, o_speed)
