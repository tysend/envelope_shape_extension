function run_augmented_experiment(subjID,startBlock)
% 2020.09.25
% Changed to be an extension of Vanessa's project.
try
	fs = filesep;
	
	% set stimulation parameters
	nAudioChans = 3;
	Sf       = 44100;
	SOA      = 11.102; % stimulus onset asynchrony in s
	durSound = 9.5;   % sound duration in s
	durRF    = 3.8;
	dBSPL    = -35; % corresponding to XX dB SPL
	dbrelMin = -60;
	N        = 56; % Number of ramps and damps per block (N/2 per condition)
	nBlocks  = 5;
	fR       = [800 2200];
	nComps   = 100;

	% initial params
	PsychDefaultSetup(2);
	InitializePsychSound;
	%pahandle = PsychPortAudio('Open', ptb_findaudiodevice('US-122 MKII / US-144 MKII'), [], 2, Sf, nAudioChans);_
	pahandle = PsychPortAudio('Open', ptb_findaudiodevice('ASIO Fireface USB'), [], 2, Sf, nAudioChans); % 13 == ^
	
	
	KbName('UnifyKeyNames');
	keysOfInterest = zeros(1,256);
	keysOfInterest(KbName('ESCAPE')) = 1;
	KbQueueCreate;
	KbQueueStart;
	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% IMPORTANT REMOVE THE NEXT LINE WHEN ON CRT!!!!
	%      Screen('Preference', 'SkipSyncTests', 1);
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	sca;                                             % close all screens
	screens      = Screen('Screens');                % get all screens available
	screenNumber = max(screens);                     % present stuff on the last screen
	Screen('Preference', 'SkipSyncTests', 1);
	white   = WhiteIndex(screenNumber);              % get white given the screen used
	
	% play once something to get the time stamps right later
	PsychPortAudio('FillBuffer',pahandle,zeros([nAudioChans 1]));
	initialTime = PsychPortAudio('Start',pahandle,1,0,1);
	
	bgcolor  = 0;                                     % background color 0-255
	txtcolor = round(white*0.8);                     % text color 0-255
	[shandle, ~] = PsychImaging('OpenWindow', screenNumber, bgcolor); % open window
	
	% Select specific text font, style and size:
	Screen('TextFont', shandle, 'Arial');
	Screen('TextSize', shandle, 22);
	Screen('TextStyle', shandle, 1);
	HideCursor;
	
	% generate randomization
	rng(str2double(subjID([3 4]))*201)
	seq = generate_sequence(N,nBlocks);
	
	for b = startBlock : nBlocks
		% Draw beginning-of-block screen
		DrawFormattedText(shandle, ['Start block ' num2str(b) '/' num2str(nBlocks) ' by pressing a button!'], 'center', 'center', txtcolor);
		Screen('Flip', shandle);
		keyIsDown = KbCheck;
		while ~keyIsDown, keyIsDown = KbCheck; end
		DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
		Screen('Flip', shandle);
		WaitSecs(5);
		
		% get onsets for sound stimulation
		currentTime = GetSecs;
		onsets = currentTime + 2 + (0:SOA:(size(seq,2)*SOA-SOA));
		
		% do sound stimulation
		times = [];
		for ii = 1 : size(seq,2)
			if seq(b,ii) == 0
				type = 'damped';
			else
				type = 'ramped';
			end
			
			% generate sound
			y = generate_complex_envel(Sf,durSound,fR,nComps,4,type,1.
			);
			y = wav_risefall(y, [0.01 0.01], Sf, 'lin');
			magMod = risefall(dBSPL,dbrelMin,Sf,durRF,length(y));
			y = y .* magMod';
			if nAudioChans == 2
				y = [y'; y'];
			elseif nAudioChans == 3
				y = [y'; y'; zeros([1 length(y)])];
				y(3,1:round(Sf*0.01)) = 1;
			else
				error('Not cool! Wrong number of audio channels.')
			end
			
			PsychPortAudio('FillBuffer',pahandle,y);
			times(ii) = PsychPortAudio('Start',pahandle,1,onsets(ii),1);
			
			[~,keyEvents] = KbQueueCheck;
			if keyEvents(logical(keysOfInterest))>0
				error('Program stopped by user!!!')
			end
			
			% wait briefly, otherwise weird sound overlap happens
			WaitSecs(length(y)/Sf+0.01);
		end
		events       = [];
		events.ons   = onsets;
		events.times = times;
		events.info  = seq(b,:);
		
		% save times and triggers
		save(['logs' fs subjID num2str(b) '.mat'],'-struct','events')
		
		% Draw end-of-block screen
		DrawFormattedText(shandle, 'End of block: Press a button!', 'center', 'center', txtcolor);
		Screen('Flip', shandle);
		keyIsDown = KbCheck;
		while ~keyIsDown, keyIsDown = KbCheck; end
		DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
		Screen('Flip', shandle);
		WaitSecs(2);
	end
	
	sca;
	PsychPortAudio('Close', pahandle);
	KbQueueStop;
	% 	IOPort('Close',portHandle)
% 	IOPort('CloseAll');
	% Not sure exactly what this does or how it's different from the line above, but
	% the line above it was throwing an error. See also below.
catch
	sca;
	PsychPortAudio('Close', pahandle);
	KbQueueStop;
	%  	IOPort('Close',portHandle)
% 	IOPort('CloseAll');
	rethrow(lasterror);
end


