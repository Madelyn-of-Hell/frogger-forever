# Log


## Obstacle
==2-4 August==  
Obstacles had a bit of a rough development process because they were my first full attempt to implement custom objects within Godot. I built them in a few stages and their development kinda overlapped with that of the player as I rehashed my concept of how it should interact with other object and who should be doing what so my documentation got rehashed a few times but I eventually decided on breaking encapsulation on the player's passive velocity so that obstacles can force the player to move with 'em. Also the obstacle tells the player to die now because it means I don't need duplicate responses to triggers on the player's end.  
The Obstacle is a great example of inheritance though: almost *everything* about the child classes are inherited from the parent classes, and the child classes are basically just static instances that exist to set a few specific variables and pass on initialisation variables to the superclass to handle.  
It's pretty great! 

