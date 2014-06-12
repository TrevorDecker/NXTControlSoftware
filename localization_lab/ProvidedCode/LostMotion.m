% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam
%
% StaffTODO:    NONE

%motion that should happen when we belive that the robot is lost 
function dPose = LostMotion()
    dPose = Pose(rand,rand,rand);
end
