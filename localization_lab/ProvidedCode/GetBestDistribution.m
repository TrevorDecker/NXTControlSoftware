% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam

% StaffTODO:	 Move away from global variables


%Given an array of maps we extract the state which is most likely to
%estimate the position of the robot correctly 
function [thisPose,p] = GetBestDistribution(pM)
  global DX;
  global DY;
  global DTH;
   
   %temp values should be overriden 
   x = 0;
   y = 0;
   th = 0;
   p = 0;
   thisPose = Pose(x,y,th);

    best = max(max(max(pM)));
    for i = 1:size(pM,1)
        for j = 1:size(pM,2)
            for k = 1:size(pM,3)
                if pM(i,j,k) == best
                    x = i*DX;
                    y = j*DY;
                    th = k*DTH;
                    p = best;
                    thisPose = Pose(x,y,th);
                    return
                end
            end
        end
    end

end

