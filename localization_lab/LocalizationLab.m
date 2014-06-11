function [] = LocalizationLab()
global DTH;      %Discrimination along th
global ROBOTMODEL;
global MAXERRORTH;

config();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  SETUP %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%coordinates x,y,th
start  = [0.9,1.0,pi/2];
finish = [0.2,0.2,1.0];
finish(3) = wrapTo2Pi(finish(3)); %for end error checking

map = mapGenerator;
configMap = calculateConfigurationSpace(map,1);

%sets up the robot 
r = robot(start(1),start(2),start(3));
r.setModel(ROBOTMODEL,'r');

%pM stands for probability map 
pM = ones(size(map,1),size(map,2),2*pi/DTH);
pM = normilize(pM);

%the best guess of where we currently are
[belivedPose(1),belivedPose(2),belivedPose(3),p] = getBestDistribution(pM);
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

[pM,r] =move(pM,[0,0,0],map,r);
gui(r,map,pM)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%  search loop %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while(1)
    %while(size(path,1) > 0 )
    %the best guess of where we currently are
    [belivedPose(1),belivedPose(2),belivedPose(3),p] = getBestDistribution(pM);
    if p < .0001
        dPose = LostMotion();
        %determines the angle we should be at
        [pM,r] = update(r,dPose,map,pM);
    elseif atDesiredLocation(belivedPose,finish)
        path = WaveFrontPlanner(configMap,[belivedPose(1),belivedPose(2)],finish);
        if size(path,1) < 1 || (path(1,1) == -1 && length(path) == 1)
            dPose = LostMotion();
        else
            dPose = r.pose(1:3) - [path(1,1), path(1,2), r.pose(3)];
        end
        %determines the angle we should be at
        dPose(3) = -wrapToPi(r.pose(3) - atan2(-dPose(2),-dPose(1)));
        [pM,r] = update(r,dPose,map,pM);
    else
         dth = wrapToPi(belivedPose(3) - finish(3));
         if( abs(dth) < MAXERRORTH)
             display('done');
             break;
         else
             dPose =  [0,0,-dth];
             [pM,r] = update(r,dPose,map,pM);
             
        end
        
    end
end
gui(r,map,pM)
calculateScore(r,finish);

end


