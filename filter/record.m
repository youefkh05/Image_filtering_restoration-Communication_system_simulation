function record(Fs,Nseconds)
%RECORD Summary of this function goes here
%   Detailed explanation goes here
warning off
ch=2;           %Number of channels--2 options--1 (mono) or 2 (stereo)
datatype='uint8';
nbits=16;       %8,16,or 24

                % to record audio data from an input device ...
...such as a microphone for processing in MATLAB
recorder=audiorecorder(Fs,nbits,ch);
disp('Start speaking..')
%Record audio to audiorecorder object,...
...hold control until recording completes
recordblocking(recorder,Nseconds);
disp('End of Recording.');
%Store recorded audio signal in numeric array
x=getaudiodata(recorder);
%Write audio file
audiowrite('input1.wav',x,Fs);
end

