function [y] = roundx(x,n)

% [y] = roundx(x,n)
%
% Input:
%	x - element/vector/matrix to round
%	n - multiple of 10^n
%
% Output:
%	y - rounded element/vector/matrix
%
% Description: The program rounds each element in x to the nearest multiple
% of 10^n. It is in essence the roundn script of matlab's mapping toolbox.
% ------------------------------------------------------------------------
% B. Herrmann, Email: bherrmann@cbs.mpg.de, 2011-12-05

if nargin < 2, fprintf('Error: Two inputs are needed!\n'); y = []; return; end
if length(n) > 1, fprintf('Error: n needs to be a scalar!\n'); y = []; return; end

p = 10^n;
y = p * round(x/p);

return;
