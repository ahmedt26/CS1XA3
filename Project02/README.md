# Tahseen Ahmed - Project 02

## Template Source
I my template from [Themezy](https://www.themezy.com/free-website-templates/151-ceevee-free-responsive-website-template). i've given proper credit to the copyright owner (StyleShout) at the bottom of the page.

## Photo Credits
The main background photo and testimonials background photos are courtesy of my brother, [Tawhid Ahmed](https://www.instagram.com/tawhid_photography_/)

## Space Tag

Space tag is a simple mouse game where you avoid the getting hit by the bad space ships. Your score is time-based: the longer you last, the better.

### Design

**Coordinate System**
Using graphicSVG, a square is used a coordinate system for the spaceship. As the mouse moves across the play field, the coorinates of the spaceship are updated to that of the mouse. Using the notify functions from graphicSVG I am also able to avoid hitboxes by just notifying whether the mouse entered a bad guy ship. This made it easier in the sense that I did not have to create hit boxes and just a simple notification. However, this is somewhat finicky: sometimes it doesn't exactly register the entrance, although I believe this is just the limitations of the Elm/graphicSVG.
**Bad Guy Behaviour**
The bad guys use varying parametric equations (trig ones) that make each type of bad guy move in a specific way. A difficulty counter (time-based) adjusts the equations to higher powers, making the bad guys move erradically and faster overtime. The equation f(x,y) = sin(3t),cos(5t) is an example of what the bad guys pathing becomes in later stages of the game.
The bad guys are also randomly positioned at the start of the game. They don't move too far away (or else they'd be mostly out of map) but it's enough to add variation and cover most of the map.
**Difficulty**
The game already starts of quite hard because of the numer of bad guys and their relative speed. I believe that game has enough varying behaviour so that there is isn't a possibility of you just hiding in a corner. I think after 30ish or more secnonds they get so fast and varied that they cover enough space so fast that you won't be able to survive.
**Art**
I did draw some nice gifs of the space ship and original badguy, but I don't know how to implement them as the actuall shapes in the game. I hope I can learn how to because I spent good time drawing them and I find that they are much more attractice than simple polygons.

### Instructions
With a full window browser, move your mouse around the playfield and avoid the spaceships. That's all there is to it.

### Requirements
A potato can run this game. The game requires that you play in a full window (non-fullscreen) because of limitations of the coordinate system I implemented for this game.A different sized screen will lead to the spcae ship not being alinged with the mouse.
### The Bad Guys
As generic as they are, each has a fairly special system of movement.
**Scout**
The original bad guy I planned for the game. Flies across the screen and wobbles a bit.
**Phaser**
This guy stays around your general vicintiy, it looks like there's two of them, but it's one guy moving really fast (a bug in the game I've made a feature). He'll make it so that you won't have straight paths away from places, making it hard to avoid bad guys.
**Strafer**
The strafers are considerably faster than the scout. They move very fast horizontally, and coveres a lot of vertical ground from swooping left and right.
**Carrier**
The carrier is the big gun. He first circles around the edge of the map, preventing you from hiding in the corners. In later stages, he'll start attacking but zooming into the field. Watch out!
