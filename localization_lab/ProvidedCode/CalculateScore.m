% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam
%
% StaffTODO:   Move away from global Variables
%              create a Pose class to make code cleaner        

%calculateScore Calculates and displays the score of the run
% thisRobot: instince of Robot which the student is trying to drive to the finish
% finishPose: triple reprsenting the desired [x,y,th] of the robot    
function calculateScore(thisRobot,finishPose)
%%% TODO Staff I don't know where to begin with this one
FT_TO_METERS = 0.3048;
IN_TO_METERS = FT_TO_METERS/12;
METERS_TO_IN = 1/IN_TO_METERS;

fprintf('end Location: x: %d y: %d th: %d \n',thisRobot.pose(1),thisRobot.pose(2),thisRobot.pose(3));
fprintf('end Goal:     x: %d y: %d th: %d \n',finishPose(1),finishPose(2),finishPose(3));
error = abs(thisRobot.pose - finishPose)*METERS_TO_IN;
fprintf('error:  x: %d y:%d th: %d \n',error(1),error(2),error(3));

L1 = error(1) + error(2);

% calulates score based on L1 error
% (difrence between desired and actual location of the robot) 
if(L1 < 3)
    score = 10;
elseif(L1 < 6)
    score = 5;
elseif(L1 < 12)
    score = 2;
else
    score = 0;
end
fprintf('score: %d',score);
end
