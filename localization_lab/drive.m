function [B_ticks,C_ticks] = drive(speed,turning,dt)
% drive 
%
%  speed The foward spped of the robotf
%  turning The angular acceleration desired of the robot
%  dt is the amount of time which you wish to have the robot drive for.
%
%  B_ticks Number of ticks from the B motor
%  C_ticks Number of ticks from the C motor


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

