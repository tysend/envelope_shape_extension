                 %% always run after matlab started
clear all; clc
format compact
fs = filesep;

direxp = 'C:\Users\CoNCH-Lab\Documents\GitHub\envelope_shape_extension';
cd(direxp)
addpath(genpath('matlab')) 

% participant ID
subjID  = 'es99a';
startBl = 1;



%% hearing threshold
run_SensationLevel(subjID)              
             

 
%% AM presentation
run_augmented_experiment(subjID,startBl);



%% burst presentation
run_augmented_experiment_bursts(subjID)

