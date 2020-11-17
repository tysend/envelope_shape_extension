clear all
format compact

try
    % set stimulation parameters
    Sf     = 44100;
    %Sf     = 96000;
    Cf     = 4000;
    SOA    = 1;
    dur    = 0.1;
    nRep   = 1000;
    stereo = 2;
	dBLev = -60;

    % generate sounds
    t    = 0:1/Sf:(dur-1/Sf);
    stim = sin(2*pi*Cf*t);
    nChan = 1;
    if stereo
        stim = [stim;stim];
        nChan = 2;
    end

    % Open Parallel Port
%     [~,res] = system('mode');
%     ports   = regexp(res,'COM\d+','match')';
%     [portHandle,error]=IOPort('OpenSerialPort',ports{1});
%     IOPort('ConfigureSerialPort', portHandle,'BaudRate=115200 DataBits=8 StopBits=1 FlowControl=None Parity=None Terminator=13 SendTimeout=1 ReceiveTimeout=1 InputBufferSize=16000')
%     pulse_time = typecast(uint32(10), 'uint8'); % length of trigger pulse
%     IOPort('Write',portHandle,uint8(['mp' pulse_time 13]));

    KbName('UnifyKeyNames');
    keysOfInterest = zeros(1,256);
    keysOfInterest(KbName('ESCAPE')) = 1;
    KbQueueCreate;
    KbQueueStart;

    % initial params
    PsychDefaultSetup(2);
    InitializePsychSound;
    %pahandle = PsychPortAudio('Open',14,[],0,Sf,nChan);
	pahandle = PsychPortAudio('Open', ptb_findaudiodevice('ASIO Fireface USB'), [], 2, Sf, 3); % 13 == ^

	
    % play once something to get the time stamps right later
    PsychPortAudio('FillBuffer',pahandle,[0;0;0]);
    initialTime = PsychPortAudio('Start',pahandle,1,0,1);

    % get onsets for sound stimulation
    currentTime = GetSecs;
    onsets = currentTime + 1 + (0:SOA:(nRep*SOA-SOA));

    % do sound stimulation
	stim = stim * db2mag(dBLev);
    stim(3,1:round(Sf*0.01)) = 0.1;
	PsychPortAudio('FillBuffer',pahandle,stim);
	[times] = deal(zeros([1 nRep]));
    for ii = 1 : nRep
		times(ii) = PsychPortAudio('Start',pahandle,1,onsets(ii),1);
        %IOPort('Write',portHandle, uint8(['mh' 255 13])); % write trigger

        [~,keyEvents] = KbQueueCheck;
        if keyEvents(logical(keysOfInterest))>0
            error('Program stopped by user!!!')
        end
        WaitSecs(dur+0.01);
    end

    KbQueueStop;
    PsychPortAudio('Close', pahandle);
    %IOPort('Close',portHandle)
catch
    KbQueueStop;
    PsychPortAudio('Close', pahandle);
    %IOPort('Close',portHandle)
end