extends Obstacle
## A child of Obstacle representing a log
class_name LogObstacle

func _init(Speed: int, direction: Direction, Length:int = 0) -> void:
	self.max_length = 8
	
	if Length == 0: 
		self.length = randi_range(1,self.max_length)
	else:
		self.length = Length % max_length + 1
		
	sprite_indices = [3,3,3]
	can_be_walked_on = true
	super._init(Speed, direction)
	self.set_name("Log")
