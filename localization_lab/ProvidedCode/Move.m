
%STAFF_TODO rename this function to something more descriptive
% causes for the robot to sense and move based on the input vector dPose
% which is the desired difrence in pose
function [pM,r] = Move(pM,dPose,map,r)
global DX;
global DY;
global DTH;
global STEPERROR

%caps max attempted motion
MAXSPEED = DX;
MAXDTH = 10*DTH;
if(abs(dPose(3)) > MAXDTH)
    dPose(3) = MAXDTH*dPose(3)/abs(dPose(3));
    dPose(1) = 0;
    dPose(2) = 0;
else
    %only translate when we are close to the correct angle
    if(abs(dPose(1)) > MAXSPEED)
        dPose(1) = MAXSPEED*dPose(1)/abs(dPose(1));
    end
    if(abs(dPose(2)) > MAXSPEED)
        dPose(2) = MAXSPEED*dPose(2)/abs(dPose(2));
    end
end
dPose(3) = -dPose(3);
%will check to see if motion is going to cause the robot to move into an
%obstacle, if so then do not allow this motion and try to execute a small
%random motion to get you away from the obstacle 
while(1)
    newPose =r.pose(1:3) -  dPose;
    newPose(3) = wrapTo2Pi(newPose(3));
    newPoseIndex(1) = round(newPose(1)/DX);
    newPoseIndex(2) = round(newPose(2)/DY);
    if newPoseIndex(1) > 0 && newPoseIndex(1) <= size(map,1) && ...
        newPoseIndex(2) > 0 && newPoseIndex(2) <= size(map,2) && ...
        map(newPoseIndex(1),newPoseIndex(2)) == 0
        r.pose = newPose;
        break;
    else
         dPose = rand(1,3)*.1;
        'hit wall'
    end
end

measurment = r.Sense(map);
pM = TransitionModel(pM,dPose');
for i = 1:size(pM,3)
    pM(:,:,i) = pM(:,:,i) + STEPERROR.*(~map);
end
pM = Normalize(pM); %normilzes
pM = ObservationModel(map,measurment,pM);
pM = Normalize(pM); %normilzes

end
