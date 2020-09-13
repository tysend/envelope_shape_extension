function [fERB fE] = erb2hertz(ERB)

% [fERB fE] = erb2hertz(ERB)
% 
% ERB  - values in ERB unit [Hz]
% fERB - a bandwidth in ERB unit [Hz] is converted to frequency unit [Hz]
% fE   - a frequency in ERB unit [Hz] is converted to frequency unit [Hz]
%
% Reference:
% Glasberg BR, Moore BCJ (1990) Derivation of auditory filter shapes from
%	notched-noise data. Hearing Research 47:103-138.
%
% Description: The program converts ERB values [Hz] to frequency values [Hz].
% -----------------------------------------------------------------------
% B. Herrmann, Email: bherrmann@cbs.mpg.de, 2012-01-03

% check inputs
if nargin ~= 1 || isempty(ERB), fprintf('Error: erb needs to be defined!\n'); fERB = []; fE = []; return; end

% calculate fERB and fE
fERB = (ERB/24.7 - 1) / 0.00437;
fE   = (10.^(ERB/21.4) - 1) / 0.00437;

return
