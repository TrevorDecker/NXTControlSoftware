% StudentTODO: NONE, in this version of the class we are giving you a
%	                working wavefront planner
%
%                   Note you should be able to write an equivalent function
%                   if asked on an exam

% StaffTODO: NONE



%normalize Ensure the sum of the probability map is 1. 
%   After applying the results of our transition and observation model,
%    our map might no longer sum to 1, which violates our assumption of 
%    a probability density function. Thus, we renormalize it. 
%
%   map: NxMx3 matrix, representing an unnormalized 'PDF' of our estimated
%       position
%
%   normalized_map: The same map, but normalized such that it sums to one. 
function [normalized_map] = normalize(map)
    normalized_map = map./sum(sum(sum(map)));
end
