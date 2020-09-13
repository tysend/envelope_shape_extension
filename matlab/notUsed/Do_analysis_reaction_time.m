clear all;
format compact;

subj = {'oa01a'};
s =1;
[y x] = analysis_reaction_time(subj{s},0);

y     = y * 1000; % ms
samps = 1:4;
steps = 1;
nn    = 1;
[slope reglines xn] = deal([]);
while samps(end) <= length(x)
	tmp            = polyfit(x(samps),y(samps),1);
	reglines(nn,:) = polyval(tmp,x(samps));
	slope(nn)      = tmp(1);
	xn(nn,:)       = x(samps);
	samps          = samps + 1;
	nn             = nn + 1;
end


figure, set(gcf,'Color',[1 1 1])
subplot(1,3,1), hold on
set(gca,'FontSize',12)
plot(x,y,'-k')
plot(x,y,'ok')
xlim([18 72])
ylim([160 260])
xlabel('Sound level')
title('Reaction times (ms)')

subplot(1,3,2), hold on
set(gca,'FontSize',12)
for ii = 1 : size(reglines,1)
	plot(xn(ii,:),reglines(ii,:),'-k')
end
xlim([18 72])
ylim([160 260])
xlabel('Sound level')
title('Local slopes')

subplot(1,3,3), hold on
set(gca,'FontSize',12)
plot([18 72],[0 0],':k')
plot(mean(xn,2),slope,'-k')
plot(mean(xn,2),slope,'ok')
xlim([18 72])
xlabel('Sound level')
ylabel('Slope')
title('Local slopes')

