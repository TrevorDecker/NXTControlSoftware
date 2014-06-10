function config()
%config Configure the current workspace for use with Localization lab.
%%% TODO STAFF: What units are we in?

global DX;       %discretization along x axis
global DY;       %discretization along y axis
global DTH;      %discretization along th
global MAXDTH;   %max speed we allow for the robot to move
global MAXSPEED; %max speed we allow the robot to translate
global MAXD;     %maximum distance that the sensor can read
global STEPERROR;%amount of error added to each cell that we might occupy

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
STEPERROR = 0.0000001; %TODO Staff Explain 'make this more deterministic'

MAXERRORX = 0.1;
MAXERRORY = 0.1;
MAXERRORTH = 0.2;

%% TODO 16-311: Confirm the following variables are set correctly.
LEFTMOTOR = 'B';
RIGHTMOTOR = 'C';

ROBOTMODEL = [ -.05, -.05,      0, 0.05,    0;
                .05, -.05,  -0.05,    0, 0.05;
                1,      1,      1,    1,    1];

end