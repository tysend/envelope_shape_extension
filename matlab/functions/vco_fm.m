function [y t] = vco_fm(x,f,phi,Sf)

% [y t] = vco_fm(x,f,phi,Sf)
%
% x   - vector ranging between -1 and 1, that describes the modulation
% f   - [min max] frequency range, corresponding to -1 and 1 in x
% phi - starting phase of the oscillator
% Sf  - sampling frequency
%
% y - vector of the modulated signal
% t - coresponding time vector
%
% Description: 
% The script produces an frequency modulation, allowing for individual rate changes.
% y = vco_fm(x,[Fmin Fmax], phi,Sf) scales the frequency modulation range so 
% that -1 and 1 values of x yield oscillations of Fmin and Fmax Hertz respectively. 
% For best results, Fmin and Fmax should be in the range 0 to Sf/2.
%
% Code adjusted from: vco.m, modulate.m
% ---------------------------------------------------------------------
% B.Herrmann, Email: bherrmann@cbs.mpg.de, 2012-09-27

Cf = mean(f);
kf = (f(2) - Cf)/Sf*2*pi;

x = x(:);
t = (0:1/Sf:((size(x,1)-1)/Sf))';

phis = kf*cumsum(x);
phis = phis + phi - phis(1);
y = sin(2*pi*Cf*t + phis);



