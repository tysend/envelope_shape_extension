function [y] = find_edges_impluse_vector(x)
 
% [y] = find_edges_impluse_vector(x)
%
% x - vector of 0 and 1
% y - [begin end] of series of 1
%
% Description: The script finds the indices for the edges in
% the impluse vector.
% ---------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2016-10-16
 
% take care of the begining & end
dx = diff(x);
[yBeg yEnd] = deal([]);
if x(1) == 1
    ix = find(dx==-1,1,'first');
    yBeg = [1 ix];
    x(1) = 0;
end
if x(end) == 1
    ix = find(dx==1,1,'last');
    yEnd = [ix+1 length(x)];
    x(end) = 0;
end
 
% find edges
dx = diff(x);
y = [find(dx==1)'+1 find(dx==-1)'];
if ~isempty(yBeg)
    y(1,:) = yBeg;
end
if ~isempty(yEnd)
    y(end,:) = yEnd;
end