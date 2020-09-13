function [y] = cosfit_intc(params,inp)

% [y] = cosfit(params,inp)
%
% params - [amplitude phase intercept]
% inp.x  - time vector
% inp.f  - frequency
% -----------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2016-09-27

a = params(1); % amplitude
p = params(2); % starting phase
i = params(3); % frequency

y = a * cos(2*pi*inp.f*inp.x+p) + i;
