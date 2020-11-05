function [y t] = generate_complex_burst(Sf,dur,fR,N)

% [y t] = generate_complex_burst(Sf,dur,fR,N)
%
% Sf    - sampling frequency, e.g., 44100
% dur   - duration (in s), e.g. 4;
% fR    - frequency range (in Hz), e.g., [500 2500]
% N     - number of frequency components, e.g., 300
%
% y - AM narrow-band noise
% t - corresponding time vector
%
% Example:
% [y t] = generate_complex_envel(44100,4,[500 2500],300,4,'ramped',1.05);
%
% Reference:
% Herrmann et al. 2017 Ageing affects dual encoding of periodicity and envelope
%      shape in rat inferior colliculus neurons. Euro J Neurosci 45:299–311
%
% Description: The script generates a narrow-band noise that is
% amplitude-modulated with different envelope shapes.
% -----------------------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2018-10-24

% get random carrier frequencies
Cfs = rand([N 1])*diff(fR)+fR(1);

% get random phases
phis = rand([N 1])*2*pi-pi;

% time vector
t = 0:1/Sf:dur-1/Sf;

% get complex signal
y = sum(sin(pi*2 * repmat(Cfs,[1 length(t)]).*repmat(t,[N 1]) + repmat(phis,[1 length(t)])));

% normalize sound
y = y / max(abs(y));
