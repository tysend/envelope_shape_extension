function [magMod] = risefall(dbMax,dbrelMin,Sf,durRF,nSamp)

% dbMax = -30;
% dbrelMin = -60;
% durRF = 4;
% Sf = 44100;
% nSamp = Sf*10;

rise = linspace(dbMax+dbrelMin,dbMax,round(Sf*durRF));
fall = fliplr(rise);
modulator = [rise ones([1 nSamp-length(rise)*2])*dbMax fall];

magMod = db2mag(modulator);
