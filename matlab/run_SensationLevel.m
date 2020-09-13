function run_SensationLevel(subjID)

fs = filesep;
 
% sound parameters
Sf   = 44100; % Sampling frequency
stim = generate_complex_unmod(Sf,15,[900 3600],100);
stim = wav_risefall(stim,[0.02 0.02],Sf,'lin'); % Add fade in/out (rise/fall)

% do sensation level
[Tm, Tdb] = ptb_sensation_level(stim,Sf,[-120 -55],6); % This is the actual test and presentation script.

% save threshold
thresh = [];
thresh.Tm  = Tm;
thresh.Tdb = Tdb;
save(['thresholds' fs subjID '_hearing.mat'],'-struct','thresh') % Save only the scalar structure "thresh".
