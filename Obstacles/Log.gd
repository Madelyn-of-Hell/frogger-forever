extends Obstacle
## A child of Obstacle representing a log
class_name LogObstacle

func _init(Speed, direction: Direction, Length:int = 0) -> void:
	sprite_sheet = preload("res://Assets/Log.png")
	can_be_walked_on = false
	max_length = 8
	super._init(Speed, direction, Length)
