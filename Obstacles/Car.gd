extends Obstacle
## A child of Obstacle representing a car
class_name CarObstacle

func _init(Speed, direction: Direction, Length:int = 0) -> void:
	sprite_sheet = preload("res://Assets/Car.png")
	can_be_walked_on = false
	max_length = 4
	super._init(Speed, direction, Length)
