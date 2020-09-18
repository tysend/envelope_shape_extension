% %% Paths
% % Path 1: use wav_risefall() with 'lin' and then apply mag2db.
% % Path 2: apply mag2db inside of wav_risefall().
% 
% %% Path 1
% %% Create Complex Sound with Envelope
% Sf =    44100;         % sampling frequency
% dur =   10;            % duration
% fR =    [900 1800];    % frequency range
% N =     150;           % # of frequency components
% Mf =    4;             % modulation frequency (AM) in Hz
% type =  'damped';      % type of modulation: 'ramped' or 'damped'
% param = 1.15;          % steepness of the modulation (1.05, 1.49, 2, etc.)
% 
% [y t] = generate_complex_envel(Sf,dur,fR,N,Mf,type,param);
% % Output:
% % y // amplitude-modulated vector
% % t // corresponding time vector
% 
% %% rise/fall
% [y w] = wav_risefall(y,[5 5],Sf,'lin'); % hijacked version of this function
% % [y w] = wav_risefall(y,[0.01 0.01], Sf, 'lin'); % is this an appropriate amount of rise/fall time?
% ty = mag2db(y);
% 
% %% Plot
% plot(t, ty)

%% Listen
% sound(ty, Sf)

%% Export audio file
% audiowrite('example_damp.wav',y,Sf)

%% Path 2
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
[y w] = wav_risefall(y,[5 5],Sf,'db'); % hijacked version of this function
% [y w] = wav_risefall(y,[0.01 0.01], Sf, 'lin'); % is this an appropriate amount of rise/fall time?


%% Plot
plot(t, y, t, w)

%% Listen
sound(y, Sf)
