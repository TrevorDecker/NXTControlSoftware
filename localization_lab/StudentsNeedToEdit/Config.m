% StudentTODO: adjust values as you see fit to get better results
%              Note the current values do NOT produce A results in our
%              test solution
%
%			   Note we will test the rest of your code with our own set of
%              Configuration files and your code should produce valid results
%              for full points, 											  
%											  
%							
%StaffTODO:  move away from gloabl variables I think we should make this a class
%		     and then pass the class to each of the other classes that need it
%	  
%
%config Configure the current workspace for use with Localization lab.
% all units are in meters 
function Config()
global DX;       %discretization along x axis cells per meter
global DY;       %discretization along y axis cells per meter 
global DTH;      %discretization along th
global MAXDTH;   %max speed we allow for the robot to move radians per time step
global MAXSPEED; %max speed we allow the robot to translate meters per time step
global MAXD;     %maximum distance that the sensor can read meters

%         STEPERROR is the amount of error which each cell in probability map
%         that the robot could be in should be increased during each time step
%         this causes for the robots certainty in its location to degrade over
%		  time if no sensor measurements are recorded
global STEPERROR; %STAFFTODO does this explain the variable adequately 


global MAXERRORX;
global MAXERRORY;
global MAXERRORTH;
global LEFTMOTOR;
global RIGHTMOTOR;
global ROBOTMODEL; % Model of the robot's footprint
                 % When in doubt, make this larger than the actual robot's
                 % footprint. We use this to calculate the configuration
                 % space.

%Global values are set, must happen before any other funciton are called
DX      = .05;
DY      = .05;
DTH     = .05;
MAXDTH  = .5;
MAXSPEED= .5;
MAXD    = .5;
STEPERROR = 0.0000001;

MAXERRORX = 0.1;
MAXERRORY = 0.1;
MAXERRORTH = 0.2;

%% STUDENT TODO: Confirm the following variables are set correctly.
LEFTMOTOR = 'B';
RIGHTMOTOR = 'C';

%Robot Model is a matrix outlining what the robot looks like from above
% this is used to display the robot in the gui
ROBOTMODEL = [ -.05, -.05,      0, 0.05,    0;
                .05, -.05,  -0.05,    0, 0.05;
                1,      1,      1,    1,    1];

end
