% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam
%
% StaffTODO:   Move away from global Variables

%calculateConfigurationSpace Produce the Configuration Space that
%       represents our world.
%   Generate a Configuration Space map of all positions our robot can take
%       in the world.  
%       Note that we represent the robot as a circle, with the radius equal
%       to the minimum circle that can fully circumscribe the robot.
%
%   map Occupancy grid (MxN) representing where a robot can be (0) and
%        where it can not be (1)
%   robotRadius The maximum radius of the robot. Used to determine how far
%        the configuration space should expand from boundary <???>
%        Note that robotRadius is in grid cells, not meters because the
%        scaling along X and Y do not have to be uniform. 
function [configurationMap] = calculateConfigurationSpace(map,robotRadius)
    configurationMap = zeros(size(map,1),size(map,2));
    for i = 1:size(map,1)
        for j = 1:size(map,2)
            occupied = 0;
            for a  = -robotRadius:robotRadius
                for b = -robotRadius:robotRadius
                    occupied = max(occupied,isOccupied(i-a,j-b,map));
                end
            end
            configurationMap(i,j) = occupied;
        end
    end

end

%isOccupied Returns true if position (i, j) can be occupied.
%   Safely determines if the given i,j coordinates of map is safe for a
%       robot to be located at, if the coordinate is outside of the map
%       then it is returned that the coordinate is occupied.
%
%   Note that the caller does not need to do bounds-checking, because
%       this function does.
%
%   (i, j) Coordinate of map to check occupy-able
%   map Occupancy grid (MxN) representing where a robot can be (0) and
%        where it can't be (1)
%
%   occupied 1 if requested coordinate is occupy-able, 0 otw		
function [occupied] =  isOccupied(i,j,map)
    if(i > 0 && i <= size(map,1) && j > 0 && j <=size(map,2))
        %point is reachable 
        if map(i,j) == 0 
            occupied = 0;
        else
            occupied = 1;
        end
    else
        occupied = 1;
    end
end
