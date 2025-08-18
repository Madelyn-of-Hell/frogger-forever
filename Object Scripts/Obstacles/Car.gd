extends Obstacle
## A child of Obstacle representing a car
class_name CarObstacle

func _init(Speed, direction: Direction, Length:int = 0) -> void:
	max_length = 3
	
	if Length == 0: 
		self.length = randi_range(1,self.max_length)
	else:
		self.length = Length % max_length
	
	sprite_indices = [0,1,2]
	if self.length == 1: sprite_indices = [7,7,7]
	can_be_walked_on = false
	super._init(Speed, direction)
	self.set_name("Car")
