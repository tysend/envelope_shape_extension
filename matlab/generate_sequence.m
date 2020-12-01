function seq = generate_sequence(N,nBlocks)

% seq = generate_sequence(N, nBlocks)
% 
% N - number of trials per condition per block

y = [0 1];
y = repmat(y,[1, N/2]);

seq = [];
for b = 1 : nBlocks
	[~,ixr] = sort(rand([1 length(y)]));
	while check_repetitions(y(ixr),3)
		[~,ixr] = sort(rand([1 length(y)]));
	end
	seq(b,:) = y(ixr);
end

