function [y w] = wav_risefall(x,rf,Fs,method)

% [y w] = wav_risefall(x,rf,Fs,method)
%
% Obligatory inputs:
%	x - sound vector, mono
%
% Optional inputs (defaults):
%	rf     = [0.01 0.01];   % rise and fall time in s
%	Fs     = 44100;         % sampling frequency of x
%	method = 'tukey',       % 'tukey', 'lin', 'db'
%
% Output:
%	y - sound vector including rise and fall times
%	w - vector of the window applied
%
% Description: The program applies rise and fall times to a sound vector.
% -------------------------------------------------------------------------
% B. Herrmann, Email: bherrmann@cbs.mpg.de, 2012-01-08
% T. Dauer added log option, 2020-09-17

% check inputs
y = [];
if nargin < 1 || isempty(x), fprintf('Error: x needs to be defined!\n'),return; end
if ~isvector(x), fprintf('Error: x needs to be a vector!\n'), return; end
if nargin < 2 || isempty(rf), rf = [0.01 0.01]; end
if nargin < 3 || isempty(Fs), Fs = 44100; end
if nargin < 4 || isempty(method), method = 'tukey'; end
if max(size(rf)) == 1, rf(2) = rf(1); end
if ~ismember(method,{'tukey' 'lin' 'db'})
	fprintf('Info: Unrecognized method! method = ''tukey'' is used instead\n');
	method = 'tukey';
end

% have x as colum vector
x = x(:); % row becomes column
w = ones(length(x),1); % create column vector of length x with 1s

% get samples for rise and fall times
nsamp_rise = round(rf(1)*Fs);
nsamp_fall = round(rf(2)*Fs);

% get rise and fall vectors
if strcmp(method, 'lin')
	rise = linspace(0,1,nsamp_rise)';
	fall = linspace(1,0,nsamp_fall)';
elseif strcmp(method, 'tukey')
	rf_window = tukeywin(nsamp_rise*2, Fs);
	rise = rf_window(1:nsamp_rise);
	rf_window = tukeywin(nsamp_fall*2, Fs);
	fall = rf_window(end-nsamp_fall+1:end);
else strcmp(method, 'db')
    rise = db2mag(linspace(-50,0,nsamp_rise)');
    fall = db2mag(linspace(0,-50,nsamp_fall)');
end

% applied rise and fall vectors to x
x(1:nsamp_rise) = x(1:nsamp_rise).*rise;
x(end-nsamp_fall+1:end) = x(end-nsamp_fall+1:end).*fall;
y = x;

% get the applied window
w(1:nsamp_rise) = w(1:nsamp_rise).*rise;
w(end-nsamp_fall+1:end) = w(end-nsamp_fall+1:end).*fall;

return;
