function run_experiment_bisection(subjID)

try
    fs = filesep;
	
	% set stimulation parameters
    Sf     = 44100;
	dur    = 0.7;
	Cf     = 1323;
	lRespWait = 2; % duration waiting for a response
	
	% initial params
	PsychDefaultSetup(2);
	InitializePsychSound;
	pahandle = PsychPortAudio('Open',ptb_findaudiodevice('Yamaha Steinberg USB ASIO'),[],0,Sf,2);
		
	KbName('UnifyKeyNames');
	keysOfInterest = zeros(1,256);
	keysOfInterest(KbName('ESCAPE')) = 1;
	KbQueueCreate;
	KbQueueStart;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IMPORTANT REMOVE THE NEXT LINE WHEN ON CRT!!!!
    % Screen('Preference', 'SkipSyncTests', 1);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	sca;                                             % close all screens
	screens      = Screen('Screens');                % get all screens available
	screenNumber = max(screens);                     % present stuff on the last screen
	Screen('Preference', 'SkipSyncTests', 1);
	white   = WhiteIndex(screenNumber);              % get white given the screen used

    % play once something to get the time stamps right later
    PsychPortAudio('FillBuffer',pahandle,[0;0]);
    initialTime = PsychPortAudio('Start',pahandle,1,0,1);

    % get tone
	t = 0:1/Sf:dur-1/Sf;
	tone = sin(pi*2*Cf*t);
	soundStim = wav_risefall(tone,[0.001 0.007],Sf,'lin');
	
    % get sensation level
	%thresh = load(['thresholds' fs subjID '_hearing.mat']);
    thresh.Tdb=-90;
    
	bgcolor = 0;                                     % background color 0-255
	txtcolor = round(white*0.8);                     % text color 0-255
	[shandle, ~] = PsychImaging('OpenWindow', screenNumber, bgcolor); % open window

	% Select specific text font, style and size:
	Screen('TextFont', shandle, 'Arial');
	Screen('TextSize', shandle, 22);
	Screen('TextStyle', shandle, 1);
	HideCursor;

	% get sound levels
	[SeqSL SeqIX] = generate_sound_levels_bisection(subjID);
	
	% Draw beginning-of-block screen
	DrawFormattedText(shandle, [['In the following you will hear one tone at a time.\n\n'] ...
		                       ['You will be ask to indicate whether the tone was ''soft'' or ''loud''.\n\n\n\n\n'] ...
							   ['You will learn what ''soft'' and ''loud'' means in the beginning,\n\n'] ...
							   ['where only tones with two different sound levels are played to you.\n\n'] ...
							   ['After a little while tones with other sound levels will be played too.\n\n\n\n\n'] ...
		                       ['Your task: Decide AS FAST and ACCURATE AS POSSIBLE whether it is a ''soft'' or ''loud'' tone.\n\n'] ...
							   ['Press any key/button to start!']], 'center', 'center', txtcolor);
	Screen('Flip', shandle);
	keyIsDown = KbCheck;
	while ~keyIsDown, keyIsDown = KbCheck; end
	DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
	Screen('Flip', shandle);
	
	WaitSecs(3);
		
	% do sound stimulation
	[ttimes RT] = deal(NaN([1 length(SeqSL)]));
	Keys = cell([1 length(SeqSL)]);
	for ii = 1 : length(SeqSL)
		PsychPortAudio('FillBuffer',pahandle,[soundStim soundStim]' * db2ratio(thresh.Tdb+SeqSL(ii)));
		ttimes(ii) = PsychPortAudio('Start',pahandle,1,0,1);
		
		while (GetSecs - ttimes(ii)) < lRespWait;
			[keyIsDown,secs,keyCode] = PsychHID('KbCheck',[],[]);
			if keyIsDown;
				Keys{ii} = KbName(keyCode);
				RT(ii)   = secs - ttimes(ii);
			end
		end
		
		% check whether user wants to stop the program
		[~,keyEvents] = KbQueueCheck;
		if keyEvents(logical(keysOfInterest))>0
			error('Program stopped by user!!!')
		end
				
		WaitSecs(rand(1)*2+2);
	end
	WaitSecs(1);
	
	events       = [];
	events.SL    = SeqSL;
	events.rt    = RT;
	events.ix    = SeqIX;
	events.resp  = Keys;
	events.times = ttimes;
	
	% save times and triggers
	save(['logs' fs subjID 'BI.mat'],'-struct','events')

	% Draw end-of-block screen
	DrawFormattedText(shandle, 'End of block: Press a button!', 'center', 'center', txtcolor);
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


