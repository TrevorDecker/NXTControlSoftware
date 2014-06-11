function [thereYet] = atDesiredLocation(bp,dp)
% atDesiredLocation Returns 1 (true) if bp~=dp, 0 otw
%   We are there if we are within a small delta of our destination.
%
%   bp Believed Pose
%   dp Desired Pose
%   thereYet 1 if we are there, 0 otw
global  MAXERRORX;
global  MAXERRORY;
    thereYet = abs(bp(1)-dp(1))> MAXERRORX || abs(bp(2) -dp(2)) > MAXERRORY;
end