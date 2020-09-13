function [y t] = generate_complex_unmod(Sf,dur,fR,N)

% [y t] = generate_complex_envel(Sf,dur,fR,N)
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
% [y t] = generate_complex_envel(44100,4,[500 2500],300);
%
% Reference:
% Herrmann et al. 2017 Ageing affects dual encoding of periodicity and envelope
%      shape in rat inferior colliculus neurons. Euro J Neurosci 45:299–311
%
% Description: The script generates a narrow-band noise that is
% amplitude-modulated with different envelope shapes.
% -----------------------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2018-10-24

% Notes below each line of code from TD. 2020.09

% get random carrier frequencies
Cfs = rand([N 1])*diff(fR)+fR(1);
% rand(M, N]) gives you an M x N matrix: N random carrier frequencies.
% diff(X) for a vector (like fR), returns X(2)-X(1) | X(3)-X(2), etc.
% - Here, it just gives us the differences between the two input
% frequencies.
% Then add the lowest of the two frequencies to each value to put it back
% into the desired range.


% get random phases
phis = rand([N 1])*2*pi-pi;
% Again, start by generating N random numbers (in a vector).
% Multiple each one by 2pi to distribute the numbers around the upper half of the unit
% circle?
% Then subtract pi to distribute phases across the entire unit circle?

% time vector
t = 0:1/Sf:dur-1/Sf;
% Create a vector with equally spaced values for each Sf for the full
% length of dur. Because we start with 0, subtracting 1/Sf at the end is
% necessary to get the correct length for t.

% get complex signal
C = sum(sin(pi*2 * repmat(Cfs,[1 length(t)]).*repmat(t,[N 1]) + repmat(phis,[1 length(t)])));
% repmat reproduces/repeats a matrix.
    % - In the case of repmat(Cfs, [1 length(t)]), the single column of
    % carrier frequencies is repeated in each column (Sf*t number of
    % columns).
    % - Then, that matrix with repeated columns is dot multipled (array
    % multipled) by the 0:Sf matrix (t).
    % - In the case of repmat(phis,[1 length(t)]), the single column of phis is repeated/duplicated Sf*t times. 
% Before sum() you have individual sine waves that then get combined by
% sum(). This raises value above 1 and below -1, hence the normalization to
% max of 1 below.
    
% get modulated signal
y = C;
y = y / max(abs(y)); % normalize to max 1



