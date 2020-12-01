function [y t] = generate_complex_envel(Sf,dur,fR,N,Mf,type,param)

% [y t] = generate_complex_envel(Sf,dur,fR,N,Mf,type,param)
%
% Sf    - sampling frequency, e.g., 44100
% dur   - duration (in s), e.g. 4;
% fR    - frequency range (in Hz), e.g., [500 2500]
% N     - number of frequency components, e.g., 300
% Mf    - AM modulation rate, e.g., 4
% type  - 'ramped' or 'damped'
% param - steepness of ramping/damping, e.g., 1.05, 1.4991, or 2
%
% y - AM narrow-band noise
% t - corresponding time vector
%
% Example:
% [y t] = generate_complex_envel(44100,4,[500 2500],300,4,'ramped',1.05);
%
% Reference:
% Herrmann et al. 2017 Ageing affects dual encoding of periodicity and envelope
%      shape in rat inferior colliculus neurons. Euro J Neurosci 45:299–311
%
% Description: The script generates a narrow-band noise that is
% amplitude-modulated with different envelope shapes.
% -----------------------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2018-10-24

% get random carrier frequencies
Cfs = rand([N 1])*diff(fR)+fR(1);

% get random phases
phis = rand([N 1])*2*pi-pi;

% time vector
t = 0:1/Sf:dur-1/Sf;

% get complex signal
C = sum(sin(pi*2 * repmat(Cfs,[1 length(t)]).*repmat(t,[N 1]) + repmat(phis,[1 length(t)])));

% h  = fdesign.lowpass(2000, 2500, 1, 80, Sf);
% Hd = design(h, 'butter', 'MatchExactly', 'stopband');
% C = randn([round(Sf*dur) 1]);
% fy = filtfilt(Hd.sosMatrix,Hd.ScaleValues,[flipud(C);C;flipud(C)]);
% C = fy(length(C)+1:length(C)*2)';

% get envelope parameters
period = 1/Mf;             % period
nEReps = fix(dur/period);  % repetitions
% number of envelope repetitions
% fix() rounds down towards 0
nSamps = round(period*Sf); % points/period
nt     = (0:nSamps-1)/Sf;  % time vector
nt     = nt / max(nt);     % normalize period to go from t=0 to t=1 for envel. calc.
	
% get envelope
envelope = (nt.^(param-1)) .* (1-nt); % Create a single envelope
envelope = envelope./max(envelope); % Normalize it to 1
envelope = repmat(envelope,[1 nEReps]); % Repeat the envelope the correct number of times
if strcmp(type,'ramped')
	envelope  = fliplr(envelope);
end

% get modulated signal
y = C .* envelope;

% h  = fdesign.lowpass(fR(2), fR(2)*1.1, 1, 80, Sf);
% Hd = design(h, 'butter', 'MatchExactly', 'stopband');
% fy = filtfilt(Hd.sosMatrix,Hd.ScaleValues,[flipud(y');y';flipud(y')]);
% fy = fy(length(y)+1:length(y)*2)';
% 
% y = fy / max(abs(fy)); % normalize to max 1
y = y / max(abs(y)); % normalize to max 1



