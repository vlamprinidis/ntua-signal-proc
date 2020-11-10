clear all; close all;
[speechSignal,Fs]=audioread('speech_utterance.wav');
winLens = [320 370 420 480];

% Time in seconds, for the graphs
t = [0:length(speechSignal)-1]/Fs;

i = 1;
for winLen=winLens;
    winOverlap = winLen-1;
    hammW=hamming(winLen);

    sgn_diff = abs(diff(sign(speechSignal)));
    % To make things easier just add one more sample with zero value.
    sgn_diff(length(speechSignal)) = 0; % Because diff gives one sample less than the original number.

    signalFramed = buffer(speechSignal, winLen,winOverlap);
    signalWindowed = diag(sparse(hammW)) * signalFramed;

    sgn_diff_framed = buffer(sgn_diff,winLen,winOverlap);
    sgn_diff_windowed = diag(sparse(hammW))*sgn_diff_framed;

    % Short-Time Energy calculation
    shortEnergy = sum(signalWindowed.^2,1);
    % Zero Crossing Rate calculation
    zeroCross = sum(sgn_diff_windowed);

    figure(1)
    subplot(length(winLens),1,i)
    plot(t, shortEnergy,'r')
    xlabel('Time (sec)')
    ylabel('Short-Time Energy')
    title(strcat('Window Length: ',num2str(winLen),' samples'))

    figure(2)
    subplot(length(winLens),1,i)
    plot(t, zeroCross,'r')
    xlabel('Time (sec)')
    ylabel('Zero Cross Rating')
    title(strcat('Window Length: ',num2str(winLen),' samples'))
    
    i = i+1;
end

figure
plot(t,speechSignal)
xlabel('Time (sec)')
ylabel('Amplitude')
title('Speech Signal')