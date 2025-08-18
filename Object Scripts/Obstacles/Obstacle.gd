## A superclass for obstacles
extends WorldConstants 
class_name Obstacle
## In soviet Russia, Object walks on you 🇷🇺🇷🇺🇷🇺🇷🇺 🫡🫡🫡
var can_be_walked_on:bool
## The length of the given object. Pretty much only used in initialisation
var length:int
## The maximum length an object can be
var max_length:int
## The movement of the obstacle. Always gonna be horizontal; usually gonna be ±100
var velocity_x:int
## The spritesheet from which the obstacles are drawn

## The indices within the spritesheet for the parts of an object. Index 0: Front | Index 1: Body | Index 2: back |
var sprite_indices:Array[int]
## An array of sprite with length equivalent to [param length]
var sprite:Array[Sprite2D]
## A single big collider that surrounds all the sprites
var collider:Area2D

func _init(Speed:int, direction:Direction):
	if self.length == 0:
		breakpoint
	self.set_name("Obstacle")
	
	add_child(generate_sprite())
	add_child(generate_collider())
	
	self.velocity_x = Speed * direction

## Creates and positions a collider of the requisite dimensions
func generate_collider() -> Area2D:
	
	# create collider
	collider = Area2D.new()
	collider.name = "Collider"
	
	# create collider's hitbox
	var collision_shape = CollisionShape2D.new()
	collider.add_child(collision_shape)
	
	# define hitbox dimensions
	collision_shape.set_shape(RectangleShape2D.new())
	collision_shape.shape.set_size(Vector2(self.length * grid_step, grid_step))
	
	# debugging
	#print("collision shape:",collision_shape)
	#print("collision size:",collision_shape.shape.size)
	#print("collider size:",collider.scale)
	
	return collider

## Generates a Node2D containing all requisite sprites, appropriately positioned such that it can be instantiated at the origin
func generate_sprite() -> Node2D:
	# Generate the parent node
	var spriteparent = Node2D.new()
	spriteparent.name = "Sprite"
	
	# Creating the sprites
	for i in self.length:
		var new_sprite = Sprite2D.new()
		# stupid placeholder because apparently match arms need to be constant 😒
		var max = self.length - 1
		match i:
			0:
				new_sprite.set_texture(sprite_sheet.get_frame_texture("default",sprite_indices[0]))
			max:
				new_sprite.set_texture(sprite_sheet.get_frame_texture("default",sprite_indices[2]))
			_:
				new_sprite.set_texture(sprite_sheet.get_frame_texture("default",sprite_indices[1]))
		
		# Stop that ugly blurring on low-pixel textures
		new_sprite.set_texture_filter(TEXTURE_FILTER_NEAREST)
		new_sprite.set_scale(Vector2(sprite_size, sprite_size))
		
		# Offset the sprite by its index multiplied by the grid step (and add half a grid step because the alignment needed it. I guess because the anchor was in the corner but I needed the anchor to be centered? wtvr. it works
		new_sprite.position.x = (i * grid_step) - (length * grid_step) / 2 + ( grid_step * 1/2 )
		
		spriteparent.add_child(new_sprite)
		self.sprite.append(new_sprite)
	return spriteparent


func _physics_process(delta: float) -> void:
	self.position.x += velocity_x * delta
	
	# Kill the lil bugger when it's sufficiently far off-screen.
	if abs(self.position.x) > screen_width * grid_step * 1.5:
		queue_free()
