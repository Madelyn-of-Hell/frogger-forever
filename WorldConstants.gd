extends Node2D
class_name WorldConstants

## The size of the grid upon which world objects exist
const grid_step:int = 76
const sprite_size:float = 0.07*grid_step
## A polarised enumerator representing either left or right (-1 or 1)
enum Direction {
	left = -1,
	right = 1
}
