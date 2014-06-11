% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam

% StaffTODO:    Move away from global Variables

%generates a list of the open spaces to pick the start and end location
function open = findOpenList(map)
global EMPTY;
global SOLID;
global START;
global END;
open = [];
for i = 2:size(map,1)-1
    for j = 2:size(map,2)-1
        if map(i,j) == EMPTY
            open = cat(1,open,[i,j]);
        end
    end
end

end
