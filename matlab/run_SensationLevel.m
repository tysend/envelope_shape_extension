function run_SensationLevel(subjID)

fs = filesep;
 
% sound parameters
Sf   = 44100; % Sampling frequency
stim = generate_complex_unmod(Sf,15,[800 2200],100); % Creates the band noise sampling freq | duration (s) | freq range | # of freq components 
stim = wav_risefall(stim,[0.02 0.02],Sf,'lin'); % Add fade in/out (rise/fall)

% do sensation level
[Tm, Tdb] = ptb_sensation_level(stim,Sf,[-130 -60],6); % This is the actual test and presentation script.
% The final argument is the number of repetitions.

% save threshold
thresh = [];  
thresh.Tm  = Tm; % Create structure with the threshold values (as magnitude and dB).
thresh.Tdb = Tdb;
save(['thresholds' fs subjID '_hearing.mat'],'-struct','thresh') % Save only the scalar structure "thresh".
