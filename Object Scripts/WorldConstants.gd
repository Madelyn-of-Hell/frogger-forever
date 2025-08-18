extends Node2D
class_name WorldConstants

## The size of the grid upon which world objects exist
const grid_step:int = 45
## The size a 16px^2 sprite should be to fill a grid
const sprite_size:float = 0.063*grid_step
## The width (in grid units) of the screen
const screen_width:int = 760 / grid_step
## A global spritesheet containing all needed assets
var sprite_sheet:SpriteFrames = preload("res://Assets/main_sprite_sheet.tres")
## A polarised enumerator representing either left or right (-1 or 1)
enum Direction {
	left = -1,
	right = 1
}
