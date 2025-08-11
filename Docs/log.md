# Log
[back to directory](README.md#directory)
## Obstacle
==2-4 August==  
Obstacles had a bit of a rough development process because they were my first full attempt to implement custom objects within Godot. I built them in a few stages and their development kinda overlapped with that of the player as I rehashed my concept of how it should interact with other object and who should be doing what so my documentation got rehashed a few times but I eventually decided on breaking encapsulation on the player's passive velocity so that obstacles can force the player to move with 'em. Also the obstacle tells the player to die now because it means I don't need duplicate responses to triggers on the player's end.  
The Obstacle is a great example of inheritance though: almost *everything* about the child classes are inherited from the parent classes, and the child classes are basically just static instances that exist to set a few specific variables and pass on initialisation variables to the superclass to handle.  
It's pretty great! 

## Player
==4 August==  
The player went a lot smoother - partly because I didn't have to figure out how to make a resource node while doing it, partly because I already had the framework of the Obstacle to work off, partially just because it doesn't have to handle inheritance or fancy initialisation and just makes the same one player object. It was also where I solidified the concept of the grid I was going to work off: not a literal, strict grid but a system that aligns the player to the grid when not being acted on by outside circumstances and then *realigns* them after they stop being acted on by outside forces.