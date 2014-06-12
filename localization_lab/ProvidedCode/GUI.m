% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam

% StaffTODO:    Move away from global Variables

function [ output_args ] = gui(r,map,pMap)
figure(1)
clf();
 global DTH;
 global DX;
 global DY;
subplot(1,2,1)
PlotMap(map,1);
r.DrawRobot()
[thisPose,p] = GetBestDistribution(pMap);
br = Robot(thisPose);%belived robot for visulizing the belived robo 
br.setModel([-.05, -.05, 0 , 0.05, 0;
            .05, -.05, -0.05, 0 ,0.05;
             1,1,1,1,1],'g');

br.DrawRobot();
th = mod(round(thisPose.getTh()/DTH)-1,size(pMap,3) -1)+1;
subplot(1,2,2)
PlotMap(pMap(:,:,th),0)
end
