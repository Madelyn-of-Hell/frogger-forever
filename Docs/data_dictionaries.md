# Data Dictionaries
[Back to directory](README.md#directory)
## [HorizontalSlice](object_directory.md#horizontalslice)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| vertical\_length | 64-bit integer | The number of lines of the same type making up the slice | must be >= 1  <br> must be <= 5 |
| vertical\_pos | 64-bit integer | The vertical height at which the slice starts | \>= 0 |
| lines | An array of HorizontalLine | Allows the HorizontalSlice to control each individual line as necessary | Array Length determined by Vertical\_Length |
| index | 64-bit integer | An index assigned by GameHandler on creation | \>= 0 |
| slice_collider | Area2D | a non-colliding box for detecting whether the player is in the slice | \>= 0 |

## [HorizontalLine](object_directory.md#horizontalline)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| vertical\_pos | 64-bit integer | The line's vertical position | \>= 0 |
| floor\_is\_safe | Boolean | Whether or not the player can walk on the floor without dying. e.g. false in water, true on road. | true or false |
| movement\_direction | 64-bit integer | A polarised value used to determine the direction (left or right) that obstacles move on this slice. Used instead of a boolean for legibility. | \-1 or 1. |
| spawner\_cooldown | 64-bit floating point double-precision number | a decimal value used to determine the time between object spawns. increases with height. | \>0 |
| spawner\_object | Obstacle | A reference to the type of object the spawner should construct. | any static child of the Object class. |

## [River](object_directory.md#river)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| static floor\_is\_safe | Boolean | A static override of the superclass' value determining that no river can be walked on safely. | False |
| static spawner\_object | Obstacle | A static override of the superclass; value determining that the only thing rivers spawn is Logs | Log |

## [Road](object_directory.md#road)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| static floor\_is\_safe | Boolean | A static override of the superclass' value determining that roads can be traversed | True |
| static spawner\_object | Obstacle | A static override of the superclass; value determining that the only thing roads spawn is cars | Car |

## [SafeZone](object_directory.md#safezone)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| static floor\_is\_safe | Boolean | A static override of the superclass' value determining that safezones are safe to walk in. | True |
| static spawner\_object | Obstacle | A static override of the superclass; value determining that safezones should not spawn obstacles. | None |

## [Obstacle](object_directory.md#obstacle)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| can\_be\_walked\_on | Boolean | whether or not the obstacle is a platform (e.g. a log) | True, False |
| length | 64-bit Integer | the length of the object | \>= 1 |
| sprite | an Array of sprite2Ds | contains all parts of the obstacles sprite. Obstacles may be arbitrarily long based on length, and thus sprites must be made of multiple components. | Array length determined by length |
| collider | Area2D | the collider for the obstacle. | Just a normal Area2D |

## [Log](object_directory.md#log)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| static can\_be\_walked\_on | Boolean | A static override of the superclass' variable determining that logs can be walked on. | True or False |

## [Car](object_directory.md#car)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| static can\_be\_walked\_on | Boolean | A static override of the superclass' variable determining that cars cannot be walked on. May be subject to change. | True or False |

## [Player](object_directory.md#player)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| sprite | Sprite2D | The player's sprite | literally just a sprite |
| movement\_controller | CharacterBody2D | the player's collider and movement handler | just a CharacterBody2D |
| movement\_cooldown | 64-bit floating point double-precision number | the cooldown between player movement ticks | \>0 |

## [GameHandler](object_directory.md#gamehandler)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| player | Player | the game handler gets to own the player c: as a treat | just a constructed player |

| world | A linked list of HorizontalSlice | the entire world. Used for constructing more world and I might eventually free up old slices with it if anyone somehow manages to go through GIGABYTES of available ram | I mean it just has to be a list of horizontalslices as long as it's that you're chill dog |
| ui | MaddiesCoolUiSystem | A child class of the control node that's basically just a control node with some added methods for modals and stuff containing the in-game ui - pause/settings menus, movement buttons (if I add 'em) and anything else that needs to show up| Just a blank control node. Its entire purpose is to have and make children lol|

## [WorldController](object_directory.md#worldcontroller)

| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| current_scene | PackedScene | it's a wrapper for the current scene so you never have to technically switch scenes. Doing it like this because I like doing it this way better. | It's literally just any scene. It'll default to the main menu tho dw pookie |

## [MaddiesCoolUiSystem](object_directory.md#maddiescooluisystem)
| Value | Type | Purpose | Parameters |
| --- | --- | --- | --- |
| yeah sorry kinda phoned it in with this one it's basically a child of control so all that just gets inherited. byeee \^•\^||||