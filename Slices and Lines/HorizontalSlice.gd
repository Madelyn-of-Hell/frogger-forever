extends WorldConstants
class_name HorizontalSlice
# MADDIE WRITE IT SO THAT ALL THE LINES ASK DADDY SLICE FOR PERMISSION TO CREATE A NEW LINE BUT DADDY SLICE ONLY DOES IT THE FIRST TIME OK BYE GNIGHT SLEEP NOW YOU NEED IT YOU TIRED FUCKING MORON 
var maximum_length:int
var difficulty_scaler:float = 2
var slice_type:SliceType
var vertical_length:int
var vertical_pos:int
var lines:Array[HorizontalLine]
var index:int

func _init(v_pos:int, array_index:int, v_length:int = 0, type:SliceType = SliceType.None):
	self.index = array_index
	self.vertical_pos = v_pos
	
	maximum_length = floor(3 + (self.index * self.difficulty_scaler))
	if v_length == 0:
		self.vertical_length = randi_range(1,self.maximum_length)
	elif v_length > self.maximum_length:
		self.vertical_length = v_length % self.maximum_length
	elif v_length <= self.maximum_length:
		self.vertical_length = v_length
	
	if type == SliceType.None:
		self.slice_type = SliceType.get(SliceType.keys()[randi_range(0,2)])
	else: 
		self.slice_type = type
	for i in self.vertical_length:
		var new_line:HorizontalLine
		match self.slice_type:
			SliceType.Road: new_line = Road.new(vertical_pos - i, Direction.left, randf_range(10,70) / difficulty_scaler)
			SliceType.River: new_line = River.new(vertical_pos - i, Direction.get(Direction.keys()[randi_range(0,1)]), 2 * difficulty_scaler)
			SliceType.SafeZone: new_line = SafeZone.new(vertical_pos + i, Direction.right, 999)
			_:  push_error("SLICE TYPE INVALID LINE 35")
		new_line.position.y = -i * grid_step 
		
		add_child(new_line)
	
	#slice_collider = Area2D.new()
	#
	#var collision_shape = CollisionShape2D.new()
	#slice_collider.add_child(collision_shape)
	#
	## define hitbox dimensions
	#collision_shape.set_shape(RectangleShape2D.new())
	#collision_shape.shape.set_size(Vector2(grid_step * screen_width, self.vertical_length * grid_step))
	#
	## Evil badbadbad alignment hack. No clue what's wrong but it's been hours so I just keep patching in new fixes as I find em...
	#slice_collider.set_position(Vector2(0,-grid_step + ((3- self.vertical_length) % 3)/2*grid_step))
	#if self.vertical_length % 2 == 0: slice_collider.position.y += grid_step/2
	#if self.vertical_length == 4: slice_collider.position.y -= grid_step
	#add_child(slice_collider)
	
	name = "%sSlice %s" % [SliceType.find_key(self.slice_type), self.index]

enum SliceType {
	Road,
	River,
	SafeZone,
	None
}
