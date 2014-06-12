% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam
%
% StaffTODO:  make what is needed for forward kinematics clearer

%  speed:  The desired foward speed of the robot
%  turning:  The angular acceleration desired of the robot
%  dt: is the amount of time which you wish to have the robot drive for.
%
%  B_ticks Number of ticks from the B motor
%  C_ticks Number of ticks from the C motor								 
function [B_ticks,C_ticks] = drive(speed,turning,dt)


leftSpeed = 0;
rightSpeed = 0;
%% TODO 16-311: Implement forward kinematics


mB = NXTMotor('B', 'Power', leftSpeed);
mC = NXTMotor('C', 'Power', rightSpeed);

%resets motors
mB.ResetPosition();
mC.ResetPosition();
mB.SendToNXT();
mC.SendToNXT();
pause(dt);
B_ticks = mB.ReadFromNXT().position;
C_ticks = mC.ReadFromNXT().position;

end

