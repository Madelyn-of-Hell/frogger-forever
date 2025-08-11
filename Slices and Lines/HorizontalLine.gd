extends WorldConstants
class_name HorizontalLine

var vertical_pos: int
var floor_is_safe: bool
var movement_direction: Direction
var spawner_cooldown: float
var spawner_timer: Timer
var spawner_object
var floor_sprite:Texture2D
var obstacle_speed: float
var line_collider:Area2D


func _init(v_pos:int, m_direction:Direction, s_cooldown:float, o_speed:float = 100) -> void:
	if o_speed == 0:
		breakpoint
	self.vertical_pos = v_pos
	self.movement_direction = m_direction
	self.obstacle_speed = o_speed
	self.spawner_cooldown = s_cooldown
	spawner_timer = Timer.new()
	spawner_timer.set_one_shot(false)
	spawner_timer.set_autostart(true)
	spawner_timer.set_wait_time(spawner_cooldown)
	spawner_timer.timeout.connect(_spawner_timeout)
	add_child(spawner_timer)
	
	add_child(generate_sprite())
	self.line_collider = generate_collider()
	add_child(self.line_collider)

func generate_sprite() -> Node2D:
	# Generate the parent node
	var spriteparent = Node2D.new()
	spriteparent.name = "Sprite"
	
	# Creating the sprites
	for i in screen_width:
		var new_sprite = Sprite2D.new()
		new_sprite.set_texture(floor_sprite)
		# Stop that ugly blurring on low-pixel textures
		new_sprite.set_texture_filter(TEXTURE_FILTER_NEAREST)
		new_sprite.set_scale(Vector2(sprite_size, sprite_size))
		# Offset the sprite by its index multiplied by the grid step
		new_sprite.position.x = (i * grid_step) - (screen_width * grid_step) / 2 + ( grid_step * 1/2 )
		spriteparent.add_child(new_sprite)
	return spriteparent
	
## Creates and positions a collider of the requisite dimensions
func generate_collider() -> Area2D:
	
	# create collider
	var collider = Area2D.new()
	collider.name = "Collider"
	
	# create collider's hitbox
	var collision_shape = CollisionShape2D.new()
	collider.add_child(collision_shape)
	
	# define hitbox dimensions
	collision_shape.set_shape(RectangleShape2D.new())
	collision_shape.shape.set_size(Vector2(WorldConstants.screen_width * grid_step, grid_step))
	
	collider.area_entered.connect(Engine.get_main_loop().get_first_node_in_group("GameHandler").create_new_slice)
	# debugging
	#print("collision shape:",collision_shape)
	#print("collision size:",collision_shape.shape.size)
	#print("collider size:",collider.scale)
	return collider
	
	
func _spawner_timeout():
	var new_obstacle = spawner_object.new(self.obstacle_speed, self.movement_direction)
	new_obstacle.position.x = ( -screen_width / 2 ) * grid_step * movement_direction
	add_child(new_obstacle)
