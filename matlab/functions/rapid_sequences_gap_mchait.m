function [y t freqs fPool] = rapid_sequences_gap_mchait(Sf,dur,sdur,gap,ttrans,rf,frange,nFpool,rCycle,type)

% [y t freqs fPool] = rapid_sequences_gap_mchait(Sf,dur,sdur,gap,ttrans,rf,frange,nFpool,rCycle,type)
%
% Sf     - sampling frequency (in Hz)
% dur    - overall duration of the sound (in sec)
% sdur   - duration of sound snippets (in sec)
% gap    - duration of gap between sound snippets (in sec)
% ttrans - transition time point (in sec)
% rf     - rise and fall time for snippets (in sec; symmetrical)
% frange - frequency range from which sounds are drawn (in Hz)
% nFpool - size of frequency pool, logarithmically (equally) spaced corresponding to frange
% rCycle - number of frequencies for the regular sequence part
% type   - 'RAND', 'REG', 'RAND-REG', 'REG-RAND'
%
% y     - sound vector
% t     - time vector
% freqs - frequency components
% fPool - pool of frequencies
%
% Reference:
% Barascud et al. (2016) PNAS 113:E616-E625.
%
% Description: The script generates sound sequences with transistions
% between random and regular parts similar to Maria Chait's work.
% -----------------------------------------------------------------------
% B. Herrmann, Email: herrmann.b@gmail.com, 2016-03-05


nPiepsT = [round(ttrans/(sdur+gap)) round((dur-ttrans)/(sdur+gap))];
nPieps  = round(dur/(sdur+gap));
fPool   = 10.^linspace(log10(frange(1)),log10(frange(2)),nFpool);

if strcmp(type,'RAND')
	ixfreqs = round(rand([1 nPieps])*(nFpool-1))+1;
	while nnz(diff(ixfreqs)==0) > 0
		ixfreqs = round(rand([1 nPieps])*(nFpool-1))+1;
	end
elseif strcmp(type,'REG')
	nCycles = floor(nPieps/rCycle);
	ixftmp  = round(rand([1 rCycle])*(nFpool-1))+1;
	while nnz(diff(ixftmp)==0) > 0 || isequal(ixftmp(1),ixftmp(end))
		ixftmp = round(rand([1 rCycle])*(nFpool-1))+1;
	end
	ixfreqs = [repmat(ixftmp,[1 nCycles]) ixftmp(1:end-nPieps-nCycles*rCycle)];
elseif strcmp(type,'RAND-REG')
	ixfreqs = round(rand([1 nPiepsT(1)])*(nFpool-1))+1;
	while nnz(diff(ixfreqs)==0) > 0
		ixfreqs = round(rand([1 nPiepsT(1)])*(nFpool-1))+1;
	end
	nCycles = floor(nPiepsT(2)/rCycle);
	ixftmp  = round(rand([1 rCycle])*(nFpool-1))+1;
	while nnz(diff(ixftmp)==0)>0 || ixftmp(1)==ixftmp(end) || ixftmp(1)==ixfreqs(end)
		ixftmp = round(rand([1 rCycle])*(nFpool-1))+1;
	end
	ixfreqs = [ixfreqs repmat(ixftmp,[1 nCycles]) ixftmp(1:end-nPiepsT(2)-nCycles*rCycle)];
elseif strcmp(type,'REG-RAND')
	nCycles = floor(nPiepsT(1)/rCycle);
	ixftmp  = round(rand([1 rCycle])*(nFpool-1))+1;
	while nnz(diff(ixftmp)==0)>0 || ixftmp(1)==ixftmp(end)
		ixftmp = round(rand([1 rCycle])*(nFpool-1))+1;
	end
	ixfreqs = [repmat(ixftmp,[1 nCycles]) ixftmp(1:end-nPiepsT(1)-nCycles*rCycle)];
	ixftmp = round(rand([1 nPiepsT(2)])*(nFpool-1))+1;
	while nnz(diff(ixftmp)==0)>0 || ixfreqs(end)==ixftmp(1)
		ixftmp = round(rand([1 nPiepsT(2)])*(nFpool-1))+1;
	end
	ixfreqs = [ixfreqs ixftmp];
end

% get actual frequencies
freqs = fPool(ixfreqs);
ts = 0:1/Sf:sdur-1/Sf;

% get rise and fall ramps
tc = 0:1/Sf:rf-1/Sf;
rramp = cos(2*pi*(1/rf/4)*tc+pi)+1;
framp = fliplr(rramp);

% prepare gap
sil = zeros([1 round(gap*Sf)]);

% generate sound
y = [];
for ii = 1 : length(freqs)
	tone = sin(2*pi*freqs(ii)*ts);
	tone(1:length(rramp)) = tone(1:length(rramp)).*rramp;
	tone(end-length(framp)+1:end) = tone(end-length(framp)+1:end).*framp;
	y = [y tone sil];
end

% get time vector
t = (0:length(y)-1)/Sf;

