function seq = generate_sequence(subjID,N)

% seq = generate_sequence(subjID,N)
% 
% subjID - es01a
% N - number of trials per condition per block

rng(str2double(subjID([3 4])))

y = [0 0 1 1; 0 1 0 1];
y = repmat(y,[1, N]);

seq = [];
for b = 1 : 6
	[~,ixr] = sort(rand([1 size(y,2)]));
	while check_repetitions(y(1,ixr),4) || check_repetitions(y(2,ixr),4)
		[~,ixr] = sort(rand([1 size(y,2)]));
	end
	seq(b).info = y(:,ixr);
end

