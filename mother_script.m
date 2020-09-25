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
subjID  = 'es02a';
% es02a is my complete run through of Vanessa's original on 2020.09.25
% using computer headphones





%% (3) measure hearing threshold
run_SensationLevel(subjID)              
              

 
%% (5) run regularity patterns
% run_experiment(subjID,1) 
run_augmented_experiment(subjID,1);
% ^ Augmented version is the extension of Vanessa's project. It has the dB
% filter overlaying the ramp/damp.


