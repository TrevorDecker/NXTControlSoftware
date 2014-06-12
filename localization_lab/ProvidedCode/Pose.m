% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam
%
% StaffTODO:    Write Tester functions
%               Finish implmenting                     
%
%a pose is a position and orintation this class encodes this information in an
%easy to access and use way 
%
% currently implmneted as SE2

classdef Pose

	properties
          x = 0;
          y = 0;
         th = 0;
    end
    
    methods
        function thisPose = Pose(varargin)
            varCount = length(varargin);
            x = 0;
            y = 0;
            th = 0;
            %in varCount == 0 case x,y,th stay 0
            if(varCount == 3)
                x  = varargin{1};
                y  = varargin{2};
                th = varargin{3};
            elseif(varCount ~= 0)
                err = MException('ResultChk:OutOfRange', ...
                  'Pose requires 3 or 0 arguments');
              throw(err);
            end
            thisPose = thisPose.setX(x);
            thisPose = thisPose.setY(y);
            thisPose = thisPose.setTh(th);
        end

        function X = getX(thisPose)
        	X = thisPose.x;
        end

        function Y = getY(thisPose)
            Y = thisPose.y;
        end

        function Th = getTh(thisPose)
            Th = thisPose.th;
        end

        function thisPose = setX(thisPose,newX)
            thisPose.x = newX;
        end

        function thisPose = setY(thisPose,newY)
            thisPose.y = newY;
        end

        function thisPose = setTh(thisPose,newTh)
            thisPose.th = wrapTo2Pi(newTh);
        end
        
        %extracts the homogeneousMatrix from the psoe state 
        function hMatrix = getHomogeneousMatrix(thisPose)
            hMatrix = [cos(thisPose.th), -sin(thisPose.th), thisPose.x;
                       sin(thisPose.th),  cos(thisPose.th), thisPose.y;
                                      0,                 0,          1;];
        end

        function thisPose = setPoseFromHomogeneousMatrix(thisPose,hMatrix)
            thisPose.x = hMatrix(1,3);
            thisPose.y = hMatrix(2,3);
            thisPose.th = atan2(hMatrix(2,1),hMatrix(1,1));
        end
        
        %a + b
        function thisPose = plus(aPose,bPose)
           assert(isa(aPose,'Pose'));
           assert(isa(bPose,'Pose'));            
           thisPose = Pose();
           thisPose = thisPose.setX(aPose.getX()   + bPose.getX());
           thisPose = thisPose.setY(aPose.getY()   + bPose.getY());
           thisPose = thisPose.setTh(aPose.getTh() + bPose.getTh())
        end
        
        %a - b
        function thisPose = minus(aPose,bPose)
            assert(isa(aPose,'Pose'));
            assert(isa(bPose,'Pose'));
            thisPose = Pose();
            thisPose = thisPose.setX(aPose.getX() - bPose.getX());
            thisPose = thisPose.setY(aPose.getY() - bPose.getY());
            thisPose = thisPose.setTh(aPose.getTh() - bPose.getTh());
        end
        
        %-a
        function thisPose = uminus(thisPose)
            thisPose = Pose() - thisPose;
        end
        
        %+a
        function thisPose = uplus(thisPose)
            thisPose = Pose() + thisPose;
        end
        
        %a.*n
        %elment multiplication of pose
        % newx = n*a.x
        % newy = n*a.y
        % newth = n*a.th
        function thisPose = times(thisPose,n)
            thisPose = thisPose.setX(n*thisPose.getX());
            thisPose = thisPose.setY(n*thisPose.getY());
            thisPose = thisPose.setTh(n*thisPose.getTh());
        end
        
        %a*b
        %Homogenues matrix multiplication 
        function thisPose = mtimes(aPose,bPose)
            thisPose = Pose();
            aH = aPose.getHomogeneousMatrix();
            bH = bPose.getHomogeneousMatrix();
            thisPose = thisPose.setPoseFromHomogeneousMatrix(aH*bH);
        end
        
        %a./n
        %element wise division
        function thisPose = rdivide(thisPose,n)
            thisPose = thisPose.setX(thisPose.getX()/n);
            thisPose = thisPose.setY(thisPose.getY()/n);
            thisPose = thisPose.setTh(thisPose.getTh()/n);
        end
        
        
        %a/b
        %Homogeneous Matrix divison getHomogeneousMatrix
        function thisPose = mrdivide(aPose,bPose)
            thisPose = Pose();
            aH = aPose.getHomogeneousMatrix();
            bH = bPose.getHomogeneousMatrix();
            thisPose = thisPose.setPoseFromHomogeneousmatrix(aH/bH);
        end
        
        
        %a.^b
        function thisPose = power(aPose,bPose)
           %%STAFFTODO implment
        end
        
        %a^b
        function thisPose = mpower(aPose,bPose)
            %%STAFFTODO implment
        end
        
        %a == b
        function result = eq(aPose,bPose)
            result = aPose.getX() == bPose.getX() && ...
                     aPose.getY() == BPose.getY() && ...
                     aPose.getTh() == BPose.getTh();
        end
        

           
            
    end
end
								
