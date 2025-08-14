extends Sprite2D

var timer:Timer
var amplitude:float
var sin_offset:float
var base_scale = scale.x
func _ready():
	
	

	timer = Timer.new()
	timer.set_wait_time(2*PI)
	timer.set_one_shot(false)
	timer.set_autostart(true)
	add_child(timer)
	amplitude = randf_range(0.01,0.3)
	sin_offset = randf_range(0,2*PI)


func _process(delta:float):
	var step = (amplitude*sin(timer.time_left - sin_offset))
	self.set_rotation(step)
	self.set_scale(Vector2((step*base_scale) + base_scale, (step*base_scale) + base_scale))
