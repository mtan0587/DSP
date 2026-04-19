% function recSig = PlayRecordAudio(devId, playSig, fs, sampPerFrame, userStart, playChan, recChan)
%
% Use this function to record audio. You will need to know the device
% id for the recording device. If you call this function with no arguments
% it will return and print the device id list. If you do not provide a device id it
% will simply use the first device.
%
% <devId> - the recording device id number
% playSig is the signal to play
% <fs> - the sample rate (default 48000), note that the sample rate has to
%        be support by your recording device
% <sampPerFrame> - the record buffer size (default 2048)
% <userStart> - set userStart to false to automatically start recording
%               otherwise the program will prompt the user to press the return key
%
% <recSig> is the recorded signal

function recSig = PlayRecordAudio(devId, playSig, fs, sampPerFrame, userStart, playChan, recChan)

if nargin == 0
    aPR = audioPlayerRecorder ;
    recSig = aPR.getAudioDevices ;
    for I = 1 : length(recSig)
        ['Dev: ',num2str(I), ' ', recSig{I}]
    end
    return ;
end

if ~exist('fs','var') || isempty(fs)
    fs = 48000 ;
end
if ~exist('sampPerFrame','var') || isempty(sampPerFrame)
    sampPerFrame = 2048 ;
end
if ~exist('devId','var') || isempty(devId)
    devId = 1 ;
end
if ~exist('userStart','var') || isempty(userStart)
    userStart = true ;
end
if ~exist('playChan') || isempty(playChan)
    playChan = 1 ;
end
if ~exist('recChan') || isempty(recChan)
    recChan = 1 ;
end

% Setup Audio Player Recorder
aPR = audioPlayerRecorder ;
devNames = aPR.getAudioDevices ;
aPR = audioPlayerRecorder('Device',devNames{devId}, ...
                         'PlayerChannelMapping', playChan, ...
                         'RecorderChannelMapping', recChan, ...
                         'BitDepth', '24-bit integer', ...
                         'SampleRate', fs) ;

info(aPR)
% Set Record Variables
recTime = length(playSig) / fs ;
recSamp = length(playSig) ;
numFrames = floor(recSamp / sampPerFrame) ;
recSig= zeros(numFrames * sampPerFrame, length(recChan)) ; 
underRun = zeros(numFrames, 1) ;
overRun = zeros(numFrames, 1) ;


% Record and Play Audio
if userStart
    fprintf(1,'Press a key to start recording\n') ;
    pause ;
end

for I = 1 : numFrames
    beginIdx = 1 + (I-1) * sampPerFrame ;
    endIdx = beginIdx + sampPerFrame - 1 ;
    [recSig(beginIdx : endIdx,:),underRun(I),overRun(I)] = ...
            aPR(playSig(beginIdx:endIdx)) ;
    if overRun(I)
        disp('Recording Error') ;
    end
    if underRun(I)
        disp('Playing Error') ;
    end
end

release(aPR) ;
