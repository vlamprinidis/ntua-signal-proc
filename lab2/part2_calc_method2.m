t= ( 0:(length(signal)-1) )/Fs;
bitsCompressed=0;
lenYq=size(yQ,3);
B=8;
for frame=1:numWin
   for k=1:M
        bitsCompressed=bitsCompressed + B*lenYq + 16;
   end
end
bitsUncompressed=16*length(signal);
compressionRatio2=(bitsUncompressed/bitsCompressed)*100;
figure
plot(t,signal)
title('Input Signal')
xlabel('Time (sec)')
ylabel('Amplitude (Normalised)')

figure
plot(t,method2(1:length(t)))
title('Compressed Signal (With Delay), Non Adjustable Quantizer')
xlabel('Time (sec)')
ylabel('Amplitude (Normalised)')

% Find and remove the delay 
n0=finddelay(signal,method2);
noDelay2=method2(n0:end);
noDelay2=( noDelay2(1:length(signal)) )';

figure
plot(t,noDelay2)
title('Compressed Signal (Without Delay), Non Adjustable Quantizer')
xlabel('Time (sec)')
ylabel('Amplitude (Normalised)')

% Mean square error
mse2=immse(signal,noDelay2);
error2=(noDelay2-signal);
figure
plot(t,signal)
title('Error, Non Adjustable Quantizer')
xlabel('Time (sec)')
ylabel('Amplitude')
hold on
plot(t,error2)
legend('Signal','Error')