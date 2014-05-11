%This function will take in x, y, z for the ship, along with a matrix of
%moon locations, and the moon x offset and looks for collisions, it then sets
%the collision flag.

function collision = detectCollision(x, y, z, locations, moonX)
outerRadius = 24; %radius of outer part of ship
innerRadius = 12; %radius of inner part of ship

outerHeight = 8; %height of outer part of ship
innerHeight = 15; %height of inner part of ship

bubbleOffset = 2; %shifts inner portion higher to account for bubble being on top

collision = 0; %initializes the collision flag to false

for ii = 1:length(locations(:, 1))%check all moon locations
    %find distance in xy plane from ship center to moon center:
    distance = sqrt((locations(ii, 1) + (moonX - x))^2 + (locations(ii, 2) - y)^2);
    if distance < innerRadius %moon is within inner ship part
        if abs(locations(ii, 3) - (z + bubbleOffset)) < innerHeight %moon is within height of inner portion
            collision = 1; %sets collision flag to true
        end
    elseif distance < outerRadius %moon is within outer portion of ship
        if abs(locations(ii, 3) - z + bubbleOffset) < outerHeight %moon is within height of outer portion
            collision = 1; %sets collision flag to true
        end
    end
end



