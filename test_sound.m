% Getting to know the sound generation files.

%% Create Complex, Unmodulated Sound
Sf = 44100;         % sampling frequency
dur = 10;           % duration
fR = [100 200];     % frequency range
N = 3;              % # of frequency components

[y t] = generate_complex_unmod(Sf, dur, fR, N);
% See my notes in generate_complex_unmod.m for details.

%% Plot
plot(t, y)

%% Listen
sound(y, Sf)

%% PSD
pwelch(y)

%% Now add rise/fall
[y w] = wav_risefall(y,[0.02 0.02],Sf,'lin');
% arg 1 // mono sound vector
% arg 2 // rise time then fall time in seconds
% arg 3 // sampling frequency
% arg 4 // rise/fall method: can be 'lin' for linear or 'tukey' for... tukey

% Output is 
% y // sound vector with new rise and fall added
% w // vector of the applied window




%% Create Complex Sound with Envelope
Sf =    44100;         % sampling frequency
dur =   10;            % duration
fR =    [900 1800];    % frequency range
N =     150;           % # of frequency components
Mf =    4;             % modulation frequency (AM) in Hz
type =  'damped';      % type of modulation: 'ramped' or 'damped'
param = 1.15;          % steepness of the modulation (1.05, 1.49, 2, etc.)

[y t] = generate_complex_envel(Sf,dur,fR,N,Mf,type,param);
% Output:
% y // amplitude-modulated vector
% t // corresponding time vector

%% rise/fall
[y w] = wav_risefall(y,[5 5],Sf,'lin');
