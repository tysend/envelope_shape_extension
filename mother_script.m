                 %% always run after matlab started
clear all;
format compact % Suppresses extra line-feeds (new lines).
fs = filesep; % fs becomes the shorthand for signifying the directory separator for this platform. 
% Example: test_dir = ['this' fs 'that' fs 'the_other']
% test_dir =
% this/that/the_other

% direxp = 'D:\newstudies\experiments\EnShape'; % Why isn't fs used here? Where is it used?
% direxp = '/Users/tysendauer/auditory_aging/experiments/EnShape';
direxp = 'C:\Users\CoNCH-Lab\Documents\GitHub\envelope_shape_extension';
cd(direxp)
addpath(genpath('matlab')) % Adds directory to search path, genpath recursively generates toolbox path.
% https://www.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-search-path.html

% participant ID
subjID  = 'es01a';





%% (3) measure hearing threshold
run_SensationLevel(subjID)              
              

 
%% (5) run regularity patterns
run_experiment(subjID,1) 


