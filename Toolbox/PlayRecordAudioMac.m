% function recSig = PlayRecordAudioMac(devRId, devWId, playSig, fs, sampPerFrame, userStart, playChan, recChan)
%
% Use this function to record audio. You will need to know the device
% id for the recording device. If you call this function with no arguments
% it will return and print the device id list. If you do not provide a device id it
% will simply use the first device.
%
% <devRId> - the recording device id number
% <devWId> - the writing device id number
% playSig is the signal to play
% <fs> - the sample rate (default 48000), note that the sample rate has to
%        be support by your recording device
% <sampPerFrame> - the record buffer size (default 2048)
% <userStart> - set userStart to false to automatically start recording
%               otherwise the program will prompt the user to press the return key
%
% <recSig> is the recorded signal

function recSig = PlayRecordAudioMac(devRId, devWId, playSig, fs, sampPerFrame, userStart, playChan, recChan)

if nargin == 0
    aDR = audioDeviceReader ;
    aDR_Devices = aDR.getAudioDevices ;
    for I = 1 : length(aDR_Devices)
        ['Dev: ',num2str(I), ' ', aDR_Devices{I}]
    end
    aDW = audioDeviceWriter ;
    aDW_Devices = aDW.getAudioDevices ;
    for I = 1 : length(aDW_Devices)
        ['Dev: ',num2str(I), ' ', aDW_Devices{I}]
    end 
    recSig{1} = aDR_Devices ;
    recSig{2} = aDW_Devices ;
    return ;
end

if ~exist('fs','var') || isempty(fs)
    fs = 48000 ;
end
if ~exist('sampPerFrame','var') || isempty(sampPerFrame)
    sampPerFrame = 2048 ;
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

% Setup Audio Recorder
aDR = audioDeviceReader ;
devNamesR = aDR.getAudioDevices ;
aDR = audioDeviceReader('Device',devNamesR{devRId}, ...
    'NumChannels', length(recChan), ...
    'SamplesPerFrame', sampPerFrame, ...
    'BitDepth', '24-bit integer', ...
    'SampleRate', fs, ...
    'OutputDataType', 'double') ;

% Setup Audio Player
aDW = audioDeviceWriter ;
devNamesW = aDW.getAudioDevices ;
aDW = audioDeviceWriter('Device',devNamesW{devWId}, ...
    'ChannelMappingSource', 'Property', ...
    'ChannelMapping', playChan, ...
    'BufferSize', sampPerFrame, ...
    'BitDepth', '24-bit integer', ...
    'SampleRate', fs) ;


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
    [recSig(beginIdx : endIdx,:),overRun(I)]  = ...
        record(aDR) ;
    underRun(I) = aDW(playSig(beginIdx:endIdx)) ;

    if overRun(I)
        disp([num2str(I),': Recording Error']) ;
    end
    if underRun(I)
        disp([num2str(I),': Playing Error']) ;
    end
end

release(aDR) ;
release(aDW) ;
