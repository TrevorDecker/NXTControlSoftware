%
%
function [configurationMap] = calculateConfigurationSpace(map,robotRadius)
%calculateConfigurationSpace Produce the Configuration Space that
%       represents our world.
%   Generate a Configuration Space map of all positions our robot can take
%       in the world.  
%       Note that we represent the robot as a circle, with the radius equal
%       to the minimum circle that can fully circumscribe the robot. 
%
%   map Occupancy grid (MxN) representing where a robot can be (0) and 
%        where it can't be (1)
%   robotRadius how far the configuration space should expand from boundary
%robotRadius is in grid cells not meters because the scaling along x and y
%does not have to be uniform. 


    configurationMap = zeros(size(map,1),size(map,2));
    for i = 1:size(map,1)
        for j = 1:size(map,2)
            ocupied = 0; 
            for a  = -robotRadius:robotRadius
                for b = -robotRadius:robotRadius
                    ocupied = max(ocupied,nextTo(i-a,j-b,map));
                end
            end
            configurationMap(i,j) = ocupied;
        end
    end

end

%Safely determines if the given i,j coordinates of map is safe for a robot to
%be located at, if the coordinate is outside of the map then it is returned
%that the coordinate is occupied. 
function [ocupied] =  nextTo(i,j,map)
    if(i > 0 && i <= size(map,1) && j > 0 && j <=size(map,2))
        %point is reachable 
        if map(i,j) == 0 
            ocupied = 0;
        else
            ocupied = 1;
        end
    else
        ocupied = 1;
    end
end
