%This function finds the key pressed and stores it with setappdata so it is
%available to the main function.

function getKey(~, eventDat)
    keyPressed = eventDat.Key; %recording the keys pressed to a variable  
    setappdata(0, 'keyPressed', keyPressed); %save key so it can be used in other functions