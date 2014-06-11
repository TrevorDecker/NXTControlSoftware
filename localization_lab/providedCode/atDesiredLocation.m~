% atDesiredLocation Returns 1 (true) if bp~=dp, 0 otw
%   We are there if we are within a small delta of our destination.
%
%   bp Believed Pose
%   dp Desired Pose
%   thereYet 1 if we are there, 0 otw

% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam

% StaffTODO:	 Move away from global variables
function [thereYet] = atDesiredLocation(bp,dp)
global  MAXERRORX;
global  MAXERRORY;
    thereYet = abs(bp(1)-dp(1))> MAXERRORX || abs(bp(2) -dp(2)) > MAXERRORY;
end
