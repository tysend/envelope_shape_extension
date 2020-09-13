function [y] = check_repetitions(x,n)

% [y] = check_repetitions(x,n)
%
% x - vector
% n - number of allow repetitions
%
% y = 1 --> more than n repetitions
% y = 0 --> not more than n repetitions
%
% Descriptions: The script checks whether a defined number of repetitions
% is exceeded in a vector
% -----------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2015-07-23

y = 0;
step = 1:n+1;
while step(end) <= length(x)
	if length(unique(x(step)))==1
		y = 1;
		break;
	end
	step = step + 1;
end

