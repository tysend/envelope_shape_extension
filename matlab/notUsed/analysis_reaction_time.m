function [y x] = analysis_reaction_time(subjID,pflag)

% [y x] = analysis_category_scaling(subjID,pflag)
% 
% A thought: Maybe fit local linear functions 5 sampes at a time

logs = load(['logs\' subjID 'RT.mat']);

% get rid of first 10 (on cycle)
logs.SL = logs.SL(11:end);
logs.rt = logs.rt(11:end);

usl   = unique(logs.SL);
samps = 1:1; % for smoothing
steps = 1;
nn    = 1;
[y x] = deal([]);
while samps(end) <= length(usl)
	ix    = ismember(logs.SL,usl(samps));
	y(nn) = nanmedian(logs.rt(ix));
	x(nn) = mean(usl(samps));
	samps = samps + steps;
	nn    = nn + 1;
end

if pflag
	figure, set(gcf,'Color',[1 1 1]), hold on
	set(gca,'FontSize',12)
	plot(x,y,'-k')
	plot(x,y,'ok')
	ylim([0.3 0.5])
	xlabel('Sound level')
	xlabel('Reaction times (s)')
end
