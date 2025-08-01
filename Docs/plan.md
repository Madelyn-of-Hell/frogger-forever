# Project Plan
[back to directory](README.MD#directory)  
Ok so the general plan for this project is to adapt the original game Frogger, with the key difference that instead of operating on the limited scope of a single screen. 
I'll achieve this by creating a superclass defining a horizontal slice, then creating several child classes defining more specific obstacles such as roads, logjams and safe areas. 

These horizontal objects will then be instantiated by a game handler object, which will be composed of a periodically updated linked list of the aforementioned slices as well as a player object, as well as a few UI components such as a textbox for score printing, a settings/pause menu and a popup prompt annoucing controls on the first playthrough.

Some UI components, including start and pause menus as well as various popups will be handled through a modal class that will allow for various text types and parameters to be passed as variables in a manner inspired by the rust [iced](iced.rs) package, itself inspired by the elm architecture for UI design.