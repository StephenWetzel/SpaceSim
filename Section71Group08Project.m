%                          SPACE VOYAGER
%             Created By: Stephen Wetzel and Drew Lentz
%                       Section 71, Group 8


clear all; clc; close all;


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%  DISPLAY INSTRUCTIONS                                                   %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

instructions = {'             SPACE VOYAGER', 
    'Created By: Stephen Wetzel and Drew Lentz',
    '          Section 71, Group 8',
    '',
    'Directions:',
    'Arrows or wasd to move',
    'Page Up/Down or q/e to roll',
    '1, 2, 3, 4 or 7, 8, 9, 0 to change view',
    'p to pause, Esc to exit',
    'Avoid the asteroids for as long as you can.',
    '',
    '   PRESS ANY KEY TO BEGIN' };
%display intro text:
annotation('textbox', [0.43, 0.5, 0.1, 0.1], 'String', instructions);

pause; %wait for user input to begin
clf; %clear intro text off screen



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%  PLOT VARIABLES, SETTING FIGURE SIZE & POSITION                         %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

xMax =  250; %size of the plot, X direction
yMax =  150; %size of the plot, Y direction
zMax =  150; %size of the plot, Z direction

myAxes = axes('xlim', [-5 xMax], 'ylim', [-10 yMax], 'zlim', [-10 zMax]); %axes handle
view(3);
axis equal; %set axes to equal scales
view(-45, 45); %sets default view, -45 degrees about y, 45 units high
light('Position',[1 1 20]); %set lighting source
set(gca, 'Color', 'k'); %axes background color
figHandle = figure(1); %get keypress as string

title 'SPACE VOYAGER';

%setting the figure to handle keylogging
set(figHandle, 'KeyPressFcn', @(fig_obj , eventDat) getKey(fig_obj, eventDat));

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%   INITIALIZING VARIABLES                                                %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

pauseTime = 0.05; %animation pause time
collision = 0; %flag for collision detection

ii = 1; %index for loop to create stars
scale = 3; %scale placeholder for ship size
xRot=0; % rotation placeholder for ship rotation
yRot=0; % rotation placeholder for ship rotation
zRot=0; % rotation placeholder for ship rotation

xTrans = 10; %intial ship location in x
yTrans = yMax / 2; %intial ship location in y
zTrans = zMax / 2; %intial ship location in z

moonXTrans = 0; %this number just goes down by 1 each step and pushes moons towards ship
moonYTrans = 0; %translation placeholder for moons in Y direction
moonZTrans = 0; %translation placeholder for moons in Z direction
moonScale  = 1; %scaling placeholder for moons

moonNum = 1; %initial moon
moonFreq = 50; %frequency which moons are generated
step = 0; %step flag for each iteration of the collision while loop
moonVel = 1; %speed that the moons move towards ship

%moonLocations is a matrix of all the moon's starting points.
moonLocations = 0;
%moonLocations matrix (index, x, y or z): 1=x, 2=y, 3=z

%background objects:
starRadius      =  0.1; %radius of stars in background
moonRadius      =  7;   %radius of asteroids
numStars        = 35;   %this number is actually * 5

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%   CREATING SHAPES: SHIP, STARS, AND MOONS/ASTEROIDS                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%CREATING THE SHIP:
%ship pieces:
[xDisk yDisk zDisk] = ellipsoid(0,0,0,5,5,.8); %outter disk
[xBulb yBulb zBulb] = ellipsoid(0,0,0,2.25,2.25,2.5);%inner bubble
zBulb(find(zBulb<0)) = 0;%shaping the bubble

%surfacing, combining the ship pieces
h(1) = surface(xDisk, yDisk, zDisk,'FaceColor',[1 205/255 0],'EdgeColor'...
    ,'none'); %surfacing outter rim of ship
material METAL;% makes the surface shiny like metal
set(h(1), 'FaceLighting', 'gouraud'); %smooth out edges
h(2) = surface(xBulb,yBulb,zBulb,'FaceColor',[0 0 0],'EdgeColor', 'none');%inner bubble
set(h(2), 'FaceLighting', 'gouraud');%smooth out edges
combinedObject = hgtransform('parent', myAxes); %combined object handle for ship
set(h,'parent',combinedObject); %setting ship shapes to combinedObject

%CREATING THE ASTEROIDS/MOONS:
[xMoon, yMoon, zMoon] = sphere; %basic shape for moons/asteroids
xMoon = (xMoon * -moonRadius); %scaling moons in x
yMoon = (yMoon * moonRadius); %scaling moons in y
zMoon = (zMoon * moonRadius); %scaling moons in z
moons = hgtransform('parent', myAxes);

%CREATING THE STARS FOR THE BACKGROUND:
[xStar, yStar, zStar] = sphere;%basic shape for stars
xStar = xStar * starRadius; %scaling the stars in x
yStar = yStar * starRadius; %scaling the stars in y
zStar = zStar * starRadius; %scaling the stars in z

for ii = 1:numStars %add some white dots as stars
    %add them on the rear, bottom and right of axes so the ship doesn't fly
    %behind them
    stars(ii)            = surface(xStar+rand(1)*xMax, yStar + yMax, ...
        zStar+rand(1)*zMax); %rear
    stars(ii+numStars)   = surface(xStar+rand(1)*xMax, yStar + yMax, ...
        zStar+rand(1)*zMax-10); %rear
    stars(ii+2*numStars) = surface(xStar+rand(1)*xMax, yStar+rand(1)*yMax - 10,...
        zStar-10); %bottom
    stars(ii+3*numStars) = surface(xStar+rand(1)*xMax, yStar+rand(1)*yMax - 10,...
        zStar-10); %bottom
    stars(ii+4*numStars) = surface(xStar+xMax, yStar + yStar+rand(1)*yMax,...
        zStar+rand(1)*zMax); %right
end
set(stars, 'FaceColor', [1, 1, 1]); %color of stars
set(stars, 'EdgeColor', 'none'); %no lines
set(stars, 'AmbientStrength', 1); %no reflections on stars

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%   ANIMATION LOOP: SHIP TRANSLATION AND MOON PLACEMENT $ TRANSLATION     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

tic; %start timer

%loop for animation, while collision is not detected
while ~collision
    
    key = getappdata(0, 'keyPressed'); %retrieve saved key
    setappdata(0, 'keyPressed', ''); %clear out saved key
    
    [xTrans, yTrans, zTrans, xRot] = move(key, xTrans, yTrans, zTrans, xRot);
    
    if mod(step, moonFreq) == 0 %checks frequency for moon generation
        %MAKING NEW MOONS:
        moonLocations(moonNum, 1) = -moonXTrans + xMax + 0; %initial location in x
        moonLocations(moonNum, 2) = (yMax+20) * rand - 10; %initial location in y
        moonLocations(moonNum, 3) = (zMax+20) * rand - 10; %initial location in z
        
        moon(moonNum) = surface((xMoon*1.2+rand(21))+moonLocations(moonNum, 1), ...
            (yMoon*1.1+rand(21))+moonLocations(moonNum, 2), (zMoon*1.3+ ...
            rand(21))+moonLocations(moonNum, 3)); %surfacing the new moon
        set(moon(moonNum), 'FaceColor', rand(1,3)); %colorful moons
        set(moon, 'parent', moons);%update the handle for all the moons
        set(moon, 'FaceLighting', 'gouraud','EdgeColor', 'none'); %smooth out edges, remove edge lines
        moonNum = moonNum + 1; %increment moon number index
        moonFreq = moonFreq - 1; %decreasing moonFreq means the moons are generated faster
        %setting the minimum value for moon frequency
        if moonFreq < 1
            moonFreq = 1; %minimal value
        end
        moonVel = moonVel + 0.05; %increase moon speed with time
        if moonVel > 5
            moonVel = 5; %max speed
        end
    end
    
    %external function to for collision detection, returns 1 or 0
    collision = detectCollision(xTrans, yTrans, zTrans, moonLocations, ...
        moonXTrans);
    if collision
        set(h,'FaceColor', 'r') %turn ship red on collision
    end
    moonXTrans = moonXTrans - moonVel; %increments the x position of each moon
    
    %translation holder for the moons/asteroids
    moonTrans = makehgtform('translate', [moonXTrans, moonYTrans, moonZTrans]);
    
    %TRANSLATIONS FOR THE SHIP:
    zRot = zRot + 15; %spin about z axis, creates spinning flying saucer effect
    
    translation = makehgtform('translate', [xTrans, yTrans, zTrans]); %ship translation
    xRotation   = makehgtform('xrotate', (pi/180) * xRot); %Do a barrel roll
    yRotation   = makehgtform('yrotate', (pi/180) * yRot); %up and down pitch
    zRotation   = makehgtform('zrotate', (pi/180) * zRot); %left and right yaw
    scaling     = makehgtform('scale', scale); %scaling the ship size
    
    set(combinedObject, 'matrix', translation * xRotation * yRotation * ...
        zRotation * scaling); %translate the ship based on keys pressed
    
    set(moons, 'matrix', moonTrans); %translate the moons across the map
    step = step + 1; %incrementing the step
    
    time = toc; %get time for title display
    title({'Time: ', num2str(time)}); %display time elapsed
    
    pause(pauseTime); % pause for animation
    
end

time = toc; %stop timer

% DISPLAY END OF GAME STATS IN A MESSAGE BOX
mbox = msgbox(sprintf('           GAME OVER\nYou survived for %2.3g seconds.', time));
uiwait(mbox);%wait for user to close message box
close all; %CLOSE FIGURE AFTER GAME ENDS
