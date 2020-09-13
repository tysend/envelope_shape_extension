function [SeqSL idxs] = generate_sound_levels_bisection(subjID)

% [SeqSL idxs] = generate_sound_levels_bisection(subjID)


nTrialsTrain = 10;                    % repetitions for train part
nTrialsTest  = 7;                     % repetitions for test part
nSL          = 12;                    % number of different sound levels
SL_ref       = [35 55];               % sound level references
SLs          = linspace(20,70,nSL);   % test sound levels

% get individual randomization
rand('seed',str2double(subjID([3 4]))*5876)

% get training part
Train = repmat(SL_ref,[1 nTrialsTrain]);
[~,ixr] = sort(rand(size(Train)));
while check_repetitions(Train(ixr),3)
	[~,ixr] = sort(rand(size(Train)));
end
Train = Train(ixr);

% get test part
Test  = mmn_random_control(nSL, nTrialsTest, SLs)';

% final sequence
SeqSL = [Train Test];
idxs  = [false(size(Train)) true(size(Test))];
