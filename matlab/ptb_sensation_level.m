function [Tm Tdb] = ptb_sensation_level(sound,Sf,dbRange,nRep)

% [Tm Tdb] = ptb_sensation_level(sound,dbRange,nRep)
%
% sound   - sound vector; by default a 12 s, 1000 Hz sine tone is used
% Sf      - sampling frequency; default = 44100
% dbRange - the minimun and maximum decibel applied to the sound; default = [-150 -70]
% nRep    - number of repetitions per descending and ascending sound; default = 6
%
% Tm  - threshold in ratio/multiplier units; use this to multiply your sound with
% Tdb - threshold in decibel units
%
% Description: The script calculates a hearing threshold (sensation level)
% for a given sound. It applies a method of limits whereby the sound
% descends in intensity until inaudible, and then ascends until audible.
% -----------------------------------------------------------------------------------
% B. Herrmann, Email: bjoern.herrmann@outlook.com, 2015-02-17

% get all the defaults going
if nargin < 4, nRep    = 6; end
if nargin < 3, dbRange = [-120 -40]; end
if nargin < 2, Sf = 44100; end
if nargin < 1,
	sound = sine_tone(12,1000,Sf); % sine_tone() is at the bottom of this script
	sound = wav_risefall(sound,[0.1 0.1],Sf);
end

% get sound duration
sound = sound(:); % Transform sound from row to column
durSound = length(sound)/Sf; % Calculate duration of sound in seconds

% get db multipliers
dbLin  = linspace(dbRange(1),dbRange(2),length(sound));  % linear spacing between decibels
% Make line vector from low to high dB with one value for each value in
% sound
m_asc  = 10.^(dbLin/20);                                 % ascending multipliers
% Get the magnitude from the dB vector you just made 
% ydb = 20*log10(y) -->
% 10^(ydb/20) = y
m_des  = 10.^(fliplr(dbLin)/20);                         % descending multipliers
% Same process of creating magnitude from dB vector, this time flipped to
% get the descending version.
db_asc = dbLin;                                          % ascending decibel
db_des = fliplr(dbLin);                                  % descending decibel

% get ascending and descending sound
asound = sound .* m_asc';
dsound = sound .* m_des';

% initial params
PsychDefaultSetup(2);
InitializePsychSound;
% pahandle = PsychPortAudio('Open',findaudiodevice('Yamaha Steinberg USB ASIO'),[],0,Sf,2);
pahandle = PsychPortAudio('Open',findaudiodevice('TASCAM US-144 MKII'),[],0,Sf,2);


KbName('UnifyKeyNames');
% Tranform internal naming scheme from your computer's operating system to
% a common naming scheme for all operating systems.
keysOfInterest = zeros(1,256);
% Create vector (1 row, 256 columns) of zeros
keysOfInterest(KbName('ESCAPE')) = 1;
% Makes the ESCAPE key (#27 on this computer) a 1
KbQueueCreate;
% Create queue for default device
KbQueueStart;
% Start delivering keyboard events from default device


sca;                                             % close all screens
screens      = Screen('Screens');                % get all screens available
screenNumber = max(screens);                     % present stuff on the last screen
Screen('Preference', 'SkipSyncTests', 1);        % Skip the opening warning/test?      
white        = WhiteIndex(screenNumber);         % get white given the screen used

% play once something to get the time stamps right later
PsychPortAudio('FillBuffer',pahandle,[0;0]);
initialTime = PsychPortAudio('Start',pahandle,1,0,1);

try
	bgcolor  = 0;                                    % background color 0-255
	% Background color is black
    txtcolor = round(white*0.8);                     % text color 0-255
	% Make text a little greyish?
    [shandle, windowRect] = PsychImaging('OpenWindow', screenNumber, bgcolor); % open window
	
	% Get the center and size of the on screen window
	[xCenter, yCenter] = RectCenter(windowRect);
	[screenXpixels, screenYpixels] = Screen('WindowSize', shandle);
	a_up     = arrow_matrix(100);
    % Find this function below
	a_down   = flipud(arrow_matrix(100));
    % Flip array in an up/down direction.
	tmp      = [min([screenXpixels screenYpixels]) min([screenXpixels screenYpixels])] * 0.2;
	DestRect = CenterRectOnPointd([0 0 tmp],xCenter, yCenter);
	
	% Select specific text font, style and size:
	Screen('TextFont', shandle, 'Arial');
	Screen('TextSize', shandle, 22);
	Screen('TextStyle', shandle, 1);
	HideCursor;
	
	% Instruction screen 1
	DrawFormattedText(shandle, [['This short experiment estimates your hearing threshold (~2 min)!\n\n\n\n'] ...
	                           ['Press a button to start!\n\n\n\n']] ...
							   , 'center','center', txtcolor);
	Screen('Flip', shandle);
	keyIsDown = KbCheck;
	while ~keyIsDown, keyIsDown = KbCheck; end
    % Continuous check if key is depressed until one is depressed. Then the
    % following blank screen and wait.
 	DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
 	Screen('Flip', shandle);
    WaitSecs(1);
    
    % Instruction screen 2
	arrows = [a_down zeros(size(a_up)) a_up];
	arrows = [zeros([size(a_down,1) size(arrows,2)]); arrows; zeros([size(a_down,1) size(arrows,2)])];
	% ? How do the 2 lines above work?
    tmp    = [min([screenXpixels screenYpixels]) min([screenXpixels screenYpixels])] * 0.6;
	DRect  = CenterRectOnPointd([0 0 tmp],xCenter, yCenter);
	tex = Screen('MakeTexture', shandle, arrows);
	Screen('DrawTextures', shandle, tex, [], DRect, [], [], [], [0 1 0]);
    % Check out details of Screen DrawTextures? when PTB working.
	DrawFormattedText(shandle, [['Downward arrow: The sound starts loudly,\npress a button as soon as you cannot hear it anymore!\n\n'] ...
	                           ['Upward arrow: The sound starts silently,\npress a button as soon as you can hear it!']], 'center', yCenter*0.3+yCenter, txtcolor);
	DrawFormattedText(shandle, 'Press a button to start!', 'center', yCenter*0.7+yCenter, txtcolor);
	Screen('Flip', shandle);
    % Another wait:
	keyIsDown = KbCheck;
	while ~keyIsDown, keyIsDown = KbCheck; end
 	DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
 	Screen('Flip', shandle);
	WaitSecs(2);
	
	[Tm Tdb] = deal([]);
    % Distribute [] to Tm and to Tdb. Like creating them in one step.
 	for rr = 1 : nRep
 		for pp = 1 : 2  % pp = 1 --> descending; pp = 2 --> ascending
			if pp == 1
 				stim  = [dsound dsound];
 				arrow = a_down;
 			else
				stim  = [asound asound];
				arrow = a_up;
			end
			
			% check whether program is aborted
			[~,keyEvents] = KbQueueCheck;
            % ? ~ for pressed | keyEvents for firstPress? help KbQueueCheck 
			if keyEvents(logical(keysOfInterest))>0
				error('Program stopped by user!!!')
			end
			
			% draw arrow
			tex = Screen('MakeTexture', shandle, arrow);
			Screen('DrawTextures', shandle, tex, [], DestRect, [], [], [], [0 1 0]);
			Screen('Flip', shandle);
			
			% play sound
 			PsychPortAudio('FillBuffer',pahandle,stim');
 			starttime = PsychPortAudio('Start',pahandle,1,0,1);
 			[keyIsDown, endtime, keyCode] = KbCheck;
 			while ~keyIsDown && GetSecs-starttime < durSound
 				[keyIsDown, endtime, keyCode] = KbCheck;
            end
            % ^ While stimulus is playing check/record if key is depressed
			PsychPortAudio('Stop', pahandle,[],1);
			DrawFormattedText(shandle, '', 'center', 'center', txtcolor);
			Screen('Flip', shandle);
			
			% get reaction time
			RT = endtime - starttime;
			RTsamp = round(RT * Sf);
			if RTsamp > length(m_asc) || RT < 1        % exclude responses made too fast or late
				[Tm(rr,pp) Tdb(rr,pp)] = deal(NaN);
			else
				if pp == 1
					Tm(rr,pp)  = m_des(RTsamp);
					Tdb(rr,pp) = db_des(RTsamp);
				else
					Tm(rr,pp)  = m_asc(RTsamp);
					Tdb(rr,pp) = db_asc(RTsamp);
				end
			end
			
			% wait before next trial
			WaitSecs(1.5);
		end
	end
	sca;
    PsychPortAudio('Close', pahandle);
    KbQueueStop;
catch
	sca;
    PsychPortAudio('Close', pahandle);
    KbQueueStop;
	rethrow(lasterror);
end

if nnz(isnan(Tm(:))) == length(Tm)
    % nnz() returns the number of nonzero numbers. If there are NAN
    % responses for every single Tm entry, then there are 0 valid
    % responses.
	error('Error: No valid responses were made! Responses were either too early or too late.')
	[Tm Tdb] = deal([]);
elseif nnz(isnan(Tm(:)))/length(Tm) > 0.5
	disp('Info: More than half of the responses were invalid! Responses were either too early or too late.')
	Tm  = nanmean(Tm(:));
	Tdb = nanmean(Tdb(:));
else
	Tm  = nanmean(Tm(:));
	Tdb = nanmean(Tdb(:));
end

% Below are helper functions for ^ 

% get sine tone
function [y] = sine_tone(dur,Cf,Sf)
t = 0:1/Sf:(dur-1/Sf);
y = sin(2*pi*Cf*t);
	

% get rise and fall ramps
function [y] = wav_risefall(x,rf,Sf)
% get samples for rise and fall times
nsamp_rise = round(rf(1)*Sf);
nsamp_fall = round(rf(2)*Sf);

% get rise and fall vectors
rise = linspace(0,1,nsamp_rise)';
fall = linspace(1,0,nsamp_fall)';

% applied rise and fall vectors to x
x = x(:);
x(1:nsamp_rise) = x(1:nsamp_rise).*rise;
x(end-nsamp_fall+1:end) = x(end-nsamp_fall+1:end).*fall;
y = x;


% get the arrow image
function a = arrow_matrix(n)
a = [fliplr(tril(ones([n n]))) tril(ones([n n]))];
a = a(1:n/2,n/2:(n*2-n/2)-1);
a = [a; [zeros([n n/4]) ones([n n/2]) zeros([n n/4])]];
a = [zeros([n+n/2 n/4]) a zeros([n+n/2 n/4])];


% get index for primary sound driver
function dix = findaudiodevice(dname)
dix = [];
devices = PsychPortAudio('GetDevices');
for ii = 1 : length(devices)
	if strcmp(devices(ii).DeviceName,dname)
		dix = devices(ii).DeviceIndex;
	end
end
disp([devices(dix+1).DeviceName ' selected!'])

