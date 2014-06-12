
%STAFF_TODO rename this function to something more descriptive
% causes for the robot to sense and move based on the input vector dPose
% which is the desired difrence in pose
function [pM,r] = Move(pM,dPose,map,r)
global DX;
global DY;
global DTH;
global STEPERROR
assert(isa(dPose,'Pose'));

%caps max attempted motion
MAXSPEED = DX;
MAXDTH = 10*DTH;
if(abs(dPose.getTh) > MAXDTH)
    dPose.setTh(MAXDTH*dPose.getTh()/abs(dPose.getTh()));
    dPose.setTh(0);
    dPose.setTh(0);
else
    %only translate when we are close to the correct angle
    if(abs(dPose.getX()) > MAXSPEED)
        dPose.setX(MAXSPEED*dPose.getX()/abs(dPose.getX()));
    end
    if(abs(dPose.getY()) > MAXSPEED)
        dPose.setY(MAXSPEED*dPose.getY()/abs(dPose.getY()));
    end
end


dPose.setTh(-dPose.getTh()); %STAFF TODO WHY IS THIS HERE


%will check to see if motion is going to cause the robot to move into an
%obstacle, if so then do not allow this motion and try to execute a small
%random motion to get you away from the obstacle 
while(1)
    newPose =r.pose -  dPose;
    newPoseIndex(1) = round(newPose.getX()./DX);
    newPoseIndex(2) = round(newPose.getY()./DY);
    if newPoseIndex(1) > 0 && newPoseIndex(1) <= size(map,1) && ...
        newPoseIndex(2) > 0 && newPoseIndex(2) <= size(map,2) && ...
        map(newPoseIndex(1),newPoseIndex(2)) == 0
        r.pose = newPose;
        break;
    else
        LostMotion();
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
