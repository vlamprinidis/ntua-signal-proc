clear all
close all
[signal,Fs]=audioread('music_dsp18.wav');
signal=mean(signal,2); % Since this is a 2-channel signal
signal=signal/max(abs(signal));
N=512;
sigs=( buffer(signal,N) )' ;
numWin=size(sigs,1);
hannWin=( hanning(N) )' ;
for i=1:numWin
    wins(i,:)=hannWin.*sigs(i,:);
end
clear Tq f
f = (1:N/2)*Fs/N;
Tq = 3.64*(f/1000).^(-0.8) - 6.5*exp(-0.6*(f/1000 - 3.3).^2) + (10^(-3))*(f/1000).^4;