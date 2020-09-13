function SeqSL = generate_sound_levels_reaction_time(subjID)

% SeqSL = generate_sound_levels_reaction_time(subjID)


nRep = 10;                    % repetitions
nSL  = 10;                    % number of different sound levels
SLs  = linspace(20,70,nSL);   % sound levels

% get individual randomization
rand('seed',str2double(subjID([3 4]))*4356)

% get sound level sequence
SeqSL  = mmn_random_control(nSL, nRep, SLs)';


