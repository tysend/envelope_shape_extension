function semitones = hertz2semitones(f1, f2)

% semitones = hertz2semitones(f1, f2)
%
% Inputs:
%	f1 - frequency 1
%	f2 - frequency 2
%
% Output:
%	semitones - difference between the two frequencies in semitones
%
% Description: The programs gives the difference between two frequencies
% in semitones.
% -----------------------------------------------------------------------------
% M. Henry, B. Herrmann, Email: bherrmann@cbs.mpg.de, 2011-11-22

nInputs = nargin;
if nInputs < 2, fprintf('Error: Two inputs need to be defined!\n'), semitones = []; return; end;

semitones = 12 * log(f2/f1)/log(2);

return;
