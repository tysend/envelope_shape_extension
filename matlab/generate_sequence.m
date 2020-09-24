function seq = generate_sequence(subjID,N)

% seq = generate_sequence(subjID,N)
% 
% subjID - es01a
% N - number of trials per condition per block

rng(str2double(subjID([3 4])))
% Seed the random number generator using the numbers from the subject id.
% Example: es01a uses 01 as a seed. This way we can recreate the sequence
% later.

y = [0 0 1 1; 0 1 0 1];
y = repmat(y,[1, N]);

seq = [];
for b = 1 : 6
	[~,ixr] = sort(rand([1 size(y,2)]));
    % The ~ means we don't care about/save that first item.
	while check_repetitions(y(1,ixr),4) || check_repetitions(y(2,ixr),4)
		[~,ixr] = sort(rand([1 size(y,2)]));
	end
	seq(b).info = y(:,ixr);
end

