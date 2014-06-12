% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam
%
% StaffTODO:    rename this function to something more descriptive
%				Write a better description for this function 

function [pM,r] = update(r,dPose,map,pM)
        dPose = dPose.setTh(-wrapToPi(r.pose.getTh() - atan2(-dPose.getY(),-dPose.getX())));
        [pM,r] =Move(pM,dPose,map,r);
        GUI(r,map,pM)
        pause(.01)
end