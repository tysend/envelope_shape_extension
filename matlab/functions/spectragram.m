function [A xf nt] = spectragram(X,t,Sf,nsamp,flims,win)

% [A xf nt] = spectragram(X,t,Sf,nsamp,flims,win)
%
% X  - vector of signal
% t  - time vector
% Sf - sampling frequency
% nsamp - number of samples [window length, window shift]
% flims - frequency limits, e.g, [0 5000]; reduces memory load and computational time
% win - window used, e.g., @hann, @blackman
%
% Description: The script calculates a time-frequency amplitude spectrum.
% -------------------------------------------------------------------------------
% B.Herrmann, Email: bjoern.herrmann@outlook.com, 2015-03-21

% have a vector
X = X(:);

% get frequency axis
nfft = 2^18;
xf   = (0:nfft/2)*(Sf/nfft);
ixf  = xf >= flims(1) & xf <= flims(2);
xf   = xf(ixf);
ixf  = logical([ixf zeros([1 length(xf)])]);

% initialize amplitude matrix and new t
A  = zeros([nnz(ixf) length(nsamp(1):nsamp(2):length(X))]);
nt = zeros([1 length(nsamp(1):nsamp(2):length(X))]);

nn = 1;
samp = 1:nsamp(1);
while samp(end) <= length(X)
	% get window function and multiply it with the data
	xwin = window(win,length(samp));
	Y    = bsxfun(@times,X(samp),xwin);
	
	% compute FFT, F - complex numbers, fourier matrix
	F = fft(Y,nfft,1)*2/sum(xwin);

	% shorten matrix by half
	A(:,nn) = abs(F(ixf));
	
	% get new time point
	nt(nn) = mean(t(samp));
	
	% set up for next loop
	samp   = samp + nsamp(2);
	nn     = nn + 1;
end


