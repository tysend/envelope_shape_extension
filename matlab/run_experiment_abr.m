function run_experiment_abr(subjID)
% run_experiment_abr(subjID)

try
	fs = filesep;
	
	% set stimulation parameters
	nAudioChans = 3;
	Sf          = 44100;
	SOA         = 1/11.3;   % stimulus onset asynchrony in s
	dur         = 0.0001;   % sound duration in s
	dBSPL       = -25;      % corresponding to XX dB SPL ORIGINAL -35. At -30 a soft harmonic was audible
	nTrials     = 4000;

	% initial params
	PsychDefaultSetup(2);
	InitializePsychSound;
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
		
	% Draw beginning-of-block screen
	DrawFormattedText(shandle, ['ABR stimulation\n\n\nStart block by pressing a button!'], 'center', 'center', txtcolor);
	Screen('Flip', shandle);
	keyIsDown = KbCheck;
	while ~keyIsDown, keyIsDown = KbCheck; end
	DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
	Screen('Flip', shandle);
	WaitSecs(5);

	% generate sound
	y = ones([1 round(dur * Sf)]);
	y = [y; y] * db2mag(dBSPL);
	if nAudioChans == 3
		samptrig = round(Sf*0.01);
		y = [y; zeros([1 length(y)])];
		y = [y zeros([3 samptrig-length(y)])];
		y(3,1:samptrig) = 1;
	elseif nAudioChans > 3
		error('Not cool! Wrong number of audio channels.')
	end
	
	% buffer sound
	PsychPortAudio('FillBuffer',pahandle,y);
	
	% get onsets for sound stimulation
	currentTime = GetSecs;
	onsets = currentTime + 2 + (0:SOA:(nTrials*SOA-SOA));
		
	% do sound stimulation
	times = NaN(size(onsets));
	for ii = 1 : nTrials
		times(ii) = PsychPortAudio('Start',pahandle,1,onsets(ii),1);

		[~,keyEvents] = KbQueueCheck;
		if keyEvents(logical(keysOfInterest))>0
			error('Program stopped by user!!!')
		end

		% wait briefly, otherwise weird sound overlap happens
		WaitSecs(length(y)/Sf+0.002);
	end
	events       = [];
	events.ons   = onsets;
	events.times = times;
	
	% save times and triggers
	save(['logs' fs subjID '7.mat'],'-struct','events')
		
	% Draw end-of-block screen
	DrawFormattedText(shandle, 'End of ABR block: Press a button!', 'center', 'center', txtcolor);
	Screen('Flip', shandle);
	keyIsDown = KbCheck;
	while ~keyIsDown, keyIsDown = KbCheck; end
	DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
	Screen('Flip', shandle);
	WaitSecs(2);
		
	sca;
	PsychPortAudio('Close', pahandle);
	KbQueueStop;
catch
	sca;
	PsychPortAudio('Close', pahandle);
	KbQueueStop;
	rethrow(lasterror);
end