function run_experiment(subjID,startBlock)

try
    fs = filesep;
	
    % set stimulation parameters
    Sf     = 44100;
    SOA    = 5.121; % stimulus onset asynchrony
    dBSPL  = -10; % corresponding to XX dB SPL
	N      = 28;
	
    % initial params
    PsychDefaultSetup(2);
    InitializePsychSound;
    pahandle = PsychPortAudio('Open',ptb_findaudiodevice('ASIO Focusrite'),[],2,Sf,4);
		
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
    PsychPortAudio('FillBuffer',pahandle,[0;0;0;0]);
    initialTime = PsychPortAudio('Start',pahandle,1,0,1);

    bgcolor = 0;                                     % background color 0-255
	txtcolor = round(white*0.8);                     % text color 0-255
	[shandle, ~] = PsychImaging('OpenWindow', screenNumber, bgcolor); % open window

	% Select specific text font, style and size:
	Screen('TextFont', shandle, 'Arial');
	Screen('TextSize', shandle, 22);
	Screen('TextStyle', shandle, 1);
	HideCursor;

	% generate randomization
	seq = generate_sequence(subjID, N);
	
	for b = startBlock : length(seq)
		% Draw beginning-of-block screen
		DrawFormattedText(shandle, ['Start block ' num2str(b) '/' num2str(length(seq)) ' by pressing a button!'], 'center', 'center', txtcolor);
		Screen('Flip', shandle);
		keyIsDown = KbCheck;
		while ~keyIsDown, keyIsDown = KbCheck; end
		DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
		Screen('Flip', shandle);
		WaitSecs(5);
		
		% get onsets for sound stimulation
		currentTime = GetSecs;
        onsets = currentTime + 2 + (0:SOA:(size(seq(b).info,2)*SOA-SOA));
        
		% do sound stimulation
		times = [];
		for ii = 1 : size(seq(b).info,2)
			if seq(b).info(1,ii) == 0
				type = 'damped';
			else
				type = 'ramped';
			end
			
			if seq(b).info(2,ii) == 0
				fR = [900 1800];
			else
				fR = [1800 3600];
			end
			[y t]    = generate_complex_envel(Sf,4,fR,100,4,type,1.05);
			y(2,:)   = y;
			y(3:4,:) = 0;
			y(3:4,1:round(Sf*0.01)) = 1;
			
			PsychPortAudio('FillBuffer',pahandle,y * db2ratio(dBSPL));
			times(ii) = PsychPortAudio('Start',pahandle,1,onsets(ii),1);
 						
			[~,keyEvents] = KbQueueCheck;
			if keyEvents(logical(keysOfInterest))>0
				error('Program stopped by user!!!')
			end
			WaitSecs(size(y)/Sf+0.01);
		end
		events       = [];
		events.ons   = onsets;
		events.times = times;
		events.info  = seq(b).info;
		
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
	IOPort('Close',portHandle)
catch
	sca;
    PsychPortAudio('Close', pahandle);
    KbQueueStop;
 	IOPort('Close',portHandle)
	rethrow(lasterror);
end

