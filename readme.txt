%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                         SPACE VOYAGER
            Created By: Stephen Wetzel and Drew Lentz
                      Section 71, Group 8 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Manuever the space ship to avoid contact with the oncoming asteroids.
Survive as long as you possibly can.  Beware, the longer you survive,
the faster and more frequently the asteroids will come. God Speed!


To start the game, run the "Section71Group08Project.m" script in Matlab.


CONTROLS:

Use arrow keys to navigate the ship around the barrage of asteroids.

OR USE THE FOLLOWING KEYS:

W: move up
S: move down
a: move left
d: move right

EVASIVE MANUEVERS:

q,Page Up: barrel roll left
e,Page down: barrel roll right

CAMERA ANGLE:

1, or 7: Overhead view
2, or 8: Profile view
3, or 9: Head on view
4, or 0: default view (-45 degree rotation about z axis)

OTHER:
p: pause game
Esc: Exit game

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		FUNCTION FILES AND THEIR DESCRIPTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
getKey.m: determines and stores the key's pressed for use in other 
          functions.

move.m:  translates and rotates the ship depending on the keys that
         the user presses.

detectCollision.m:  checks all moon locations to determine if contact
                    between the ship and moons was detected. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                       ADVANCED FEATURES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
3D graphics improvements to enhance visual appeal:
-Use of a light source 
-Use of 'materials' function to define reflectivety, specularity of 
 objects.

Functionality:
-Use of 'keyPressed' to allow the user to navigate the ship using the 
 keyboard.
-Collision detection between the ship and asteroids.

Advanced Algorithms and code for:
-collision detection
-star generation and placement (background)
-moon generation and placement
-timer used to determine time survived
-message box to display time survived
