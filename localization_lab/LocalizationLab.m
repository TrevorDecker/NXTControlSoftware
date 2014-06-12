%TODO add comments 

%must be run from inside LocalizationLab folder 

function [] = LocalizationLab()

%removes any old variables from the workspace 
clear
%updates path to include source files
addpath('ProvidedCode','ForDrivingNXT','StudentsNeedToEdit')


global DTH;      %Discrimination along th
global ROBOTMODEL;
global MAXERRORTH;
Config();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  SETUP %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%coordinates x,y,th
startPose  = Pose(0.9,1.0,pi/2);
finishPose = Pose(0.2,0.2,1.0);

map = MapGenerator;
configMap = CalculateConfigurationSpace(map,1);

%sets up the robot 
r = Robot(startPose);
r.setModel(ROBOTMODEL,'r');

%pM stands for probability map 
pM = ones(size(map,1),size(map,2),floor(2*pi/DTH));
pM = Normalize(pM);

%the best guess of where we currently are
[belivedPose,p] = GetBestDistribution(pM);
if p < .0001
    %we are not confident about our current position so planning based on
    %our best guess will not be very helpful.
    dPose = LostMotion();
else
    gui(r,map,pM)
    path = WaveFrontPlanner(configMap,[belivedPose(1),belivedPose(2)],finish);
    if path == -1
        dPose = rand(1,3);
    end
end

zeroPose = Pose();
[pM,r] =Move(pM,zeroPose,map,r);
GUI(r,map,pM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  search loop %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while(1)
    %while(size(path,1) > 0 )
    %the best guess of where we currently are
    [belivedPose,p] = GetBestDistribution(pM);
    if p < .0001
        dPose = LostMotion();
        %determines the angle we should be at
        [pM,r] = Update(r,dPose,map,pM);
    elseif atDesiredLocation(belivedPose,finish)
        path = WaveFrontPlanner(configMap,[belivedPose],finish);
        if size(path,1) < 1 || (path(1,1) == -1 && length(path) == 1)
            dPose = LostMotion();
        else
            dPose = r.pose - path(1);
        end
        %determines the angle we should be at
        dPose = dPose.setTh(-wrapToPi(r.pose.getTh() - atan2(-dPose.getY(),-dPose.getX())));
        [pM,r] = update(r,dPose,map,pM);
    else
         dth = wrapToPi(belivedPose.getTh() - finish.getTh());
         if( abs(dth) < MAXERRORTH)
             display('done');
             break;
         else
             dPose =  Pose(0,0,-dth);
             [pM,r] = update(r,dPose,map,pM);
             
        end
        
    end
end
GUI(r,map,pM)
CalculateScore(r,finish);

end


