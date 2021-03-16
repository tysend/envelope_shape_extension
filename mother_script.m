                 %% always run after matlab started
clear all; clc
format compact
fs = filesep;

direxp = 'C:\Users\CoNCH-Lab\Documents\GitHub\envelope_shape_extension';
cd(direxp)
addpath(genpath('matlab')) 

% participant ID
subjID  = 'es95a';
startBl = 1;
% Note about using next number here.


%% hearing threshold
run_SensationLevel(subjID)              
             

 
%% AM presentation (main experiment, blocks 1-5)
run_augmented_experiment(subjID,startBl);


%% ABR (block 0)
run_experiment_abr(subjID);


%% burst presentation (== onset response, block 6)
run_augmented_experiment_bursts(subjID)
% for testing onset responses

