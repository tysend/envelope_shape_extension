function [y x] = analysis_bisection(subjID,pflag)

% [y x] = analysis_category_scaling(subjID,pflag)
% 
% A thought: Maybe fit local linear functions 5 sampes at a time

logs = load(['logs\' subjID 'BI.mat']);

d = zeros(size(logs.resp));
for ii = 1 : length(logs.resp)
	d(ii) = strcmp(logs.resp{ii},'m');
end

usl   = unique(logs.SL);
samps = 1:1; % for smoothing
nn    = 1;
[y rt x] = deal([]);
while samps(end) <= length(usl)
	ix     = ismember(logs.SL,usl(samps));
	y(nn)  = mean(d(ix));
	rt(nn) = nanmean(logs.rt(ix));
	x(nn)  = mean(usl(samps));
	samps  = samps + 1;
	nn     = nn + 1;
end

if pflag
	figure, set(gcf,'Color',[1 1 1]), hold on
	set(gca,'FontSize',12)
	plot(x,y,'-k')
	plot(x,y,'ok')
	ylim([0 1])
	xlabel('Sound level')
	ylabel('p(loud)')
	
	
	figure, set(gcf,'Color',[1 1 1]), hold on
	set(gca,'FontSize',12)
	plot(x,rt,'-k')
	plot(x,rt,'ok')
	xlabel('Sound level')
	ylabel('Reaction times (s)')
end
