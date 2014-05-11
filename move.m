%This function takes in the key pressed along with current x, y, z
%positions and rotation about the x-axis (roll) and returns a new set of x,
%y, z, and xRotation.

function [x, y, z, xRotation] = move(key, x, y, z, xRotation)
%EXTERNAL FUNCTION FOR MOVEMENTS BASED ON KEYS PRESSED
deltaY = 3; %translation in y 
deltaZ = 3; %translation in z
deltaYRoll =  5; %translation in y for the roll
deltaRoll  = 45; %translation for the roll

xMax =  250; %size of the plot in x
yMax =  150; %size of the plot in x
zMax =  150; %size of the plot in x

%Continue rotation if it has started, or reset to 0 if it has completed:
if mod(xRotation, 360) == 0
    xRotation = 0;
elseif xRotation > 0 %continue left roll
    xRotation = xRotation + deltaRoll;
    y = y - deltaYRoll;
elseif xRotation < 0 %contine right roll
    xRotation = xRotation - deltaRoll;
    y = y + deltaYRoll;
end

%TRANSLATIONS: left, right, up, down:
if strcmpi(key, 'rightarrow') ||  strcmpi(key, 'd')
    y = y - deltaY; %move right
elseif strcmpi(key, 'leftarrow') ||  strcmpi(key, 'a')
    y = y + deltaY; %move left
elseif strcmpi(key, 'uparrow') ||  strcmpi(key, 'w')
    z = z + deltaZ; %move up
elseif strcmpi(key, 'downarrow') ||  strcmpi(key, 's')
    z = z - deltaZ; %move down
    
%TRANSLATION AND ROTATION: Barrel Rolls:
%Barrel roll left
elseif strcmpi(key, 'pageup') ||  strcmpi(key, 'q')
    if xRotation == 0 
        xRotation = -deltaRoll; 
        y = y + deltaYRoll;
    end
%Barrel roll right    
elseif strcmpi(key, 'pagedown') ||  strcmpi(key, 'e')
    if xRotation == 0 
        xRotation = deltaRoll;
        y = y - deltaYRoll;
    end
%CHANGING VIEWS:
elseif strcmpi(key, '1') ||  strcmpi(key, '7')
    view(0, 90); %overhead view
elseif strcmpi(key, '2') ||  strcmpi(key, '8')
    view(0, 0); % Profile view
elseif strcmpi(key, '3') ||  strcmpi(key, '9')
    view(-90, 0); %Head on view
elseif strcmpi(key, '4') ||  strcmpi(key, '0')
    view(-45, 45); %Angled view (default)
    
elseif strcmpi(key, 'p') %pause game
    pause;
    
%Exit the game in progress:
elseif strcmpi(key, 'escape') %quits the game
    close all; %closes the figure
end

%Setting max/min values for the ships placement in x, y, z
if x > xMax %maximum position in x
    x = xMax;
elseif x < 0 %minimum position in x
    x = 0;
elseif y > yMax - 15 %maximum position in y
    y = yMax-15;
elseif y < 5 %minimum position in y
    y = 5;
elseif z > zMax -8 %maximum position in z
    z = zMax-8;
elseif z < -7 %minimum position in z
    z = -7;
end
