function [ERB E] = hertz2erb(f)

% [ERB E] = hertz2erb(f)
%
% f   - values in frequency unit [Hz]
% ERB - frequency is converted to a bandwidth in ERB unit [Hz]
% E	  - frequency is converted to a frequency in ERB unit [Hz]
%
% Reference:
% Glasberg BR, Moore BCJ (1990) Derivation of auditory filter shapes from
%	notched-noise data. Hearing Research 47:103-138.
%
% Description: The program converts frequency values [Hz] to ERB values [Hz].
% --------------------------------------------------------------------------
% B. Herrmann, Email: bherrmann@cbs.mpg.de, 2012-01-03

% check inputs
if nargin ~= 1 || isempty(f), fprintf('Error: f needs to be defined!\n'); ERB = []; E = []; return; end

% calculate ERB and E
ERB = 24.7 .* (0.00437.*f+1);
E   = 21.4 .* log10(0.00437.*f+1);

return
