% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam

% StaffTODO:    NONE

%a pose is a position and orintation this class encodes this information in an
%easy to access and use way

classdef Pose < handle

								 private:
	  x;
      y;
      th;
public:
this = Pose(this,x,y,th)

end

	X =function getX(this)
	X = this.x
	end

	Y = function getY(this)
	Y = this.y
	end

	Th = function getTh(this)
	Th = this.th
	end

	this = function setX(this,newX)
	this.x = newX
	end

	this = function setY(this,newY)
	thsi.y = newY
	end

	this = function setTh(this,newTh)
	this.th = newTh
	end

	%TODO define addition,subtraction,inverse,multiplication
end
								
%TODO consider not makeing handle
%TODO finish
%TODO test
