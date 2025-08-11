extends WorldConstants
class_name Player

var sprite:Sprite2D
var collider:Area2D
var movement_cooldown:float = 0.4
var movement_timer:Timer
var target_pos:Vector2
var passive_velocity:float
signal player_dead

func _init() -> void:
	name = "Player"
	
	set_position(Vector2(grid_step,grid_step))
	target_pos = self.get_position()
	
	sprite = Sprite2D.new()
	sprite.set_texture(preload("res://Assets/Player.png"))
	sprite.set_scale(Vector2(sprite_size,sprite_size))
	add_child(sprite)
	
	movement_timer = Timer.new()
	movement_timer.set_wait_time(movement_cooldown)
	movement_timer.set_one_shot(true)
	movement_timer.set_autostart(true)
	add_child(movement_timer)
	
	collider = Area2D.new()
	var character_collider = CollisionShape2D.new()
	character_collider.set_shape(RectangleShape2D.new())
	character_collider.shape.set_size(Vector2(grid_step, grid_step))
	collider.add_child(character_collider)
	add_child(collider)


	
func _ready() -> void:
	player_dead.connect(get_parent()._on_player_death)

func _physics_process(delta: float) -> void:
	self.position = position.lerp(target_pos, 1 - movement_timer.get_time_left()/movement_timer.get_wait_time())
	if passive_velocity != 0:
		self.position.x += passive_velocity * delta
		self.target_pos.x += passive_velocity * delta
	else:
		self.target_pos = align_to_grid(self.target_pos)
	if movement_timer.is_stopped():
		if Input.is_action_pressed("Up"):
			target_pos.y -= grid_step
		if Input.is_action_pressed("Down"):
			target_pos.y += grid_step
		if Input.is_action_pressed("Left"):
			target_pos.x -= grid_step
		if Input.is_action_pressed("Right"):
			target_pos.x += grid_step
		if Input.is_anything_pressed():
			movement_timer.start()

## Aligns a given vector to the grid defined by [class WorldConstants]
func align_to_grid(vector:Vector2) -> Vector2:
	var floored_vec = Vector2(
		round(vector.x / grid_step) * grid_step,
		round(vector.y / grid_step) * grid_step
	)
	return floored_vec

func die():
	player_dead.emit(floor(self.position.y / grid_step))
