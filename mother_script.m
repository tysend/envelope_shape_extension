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



%% burst presentation (== onset response, block 6)
run_augmented_experiment_bursts(subjID)
% for testing onset responses


%% ABR (block 7)
% Be sure to change decimation settings in ActiView before running this
% block (from 1/16 to 1). See experiment_protocol for details.
run_experiment_abr(subjID);

