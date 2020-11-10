t= ( 0:(length(signal)-1) )/Fs;
bitsCompressed=0;
lenYq=size(yQ,3);
for frame=1:numWin
   for k=1:M
        bitsCompressed=bitsCompressed + Bk(frame,k)*lenYq + 16;
   end
end
bitsUncompressed=16*length(signal);
compressionRatio1=(bitsUncompressed/bitsCompressed)*100;
figure
plot(t,signal)
title('Input Signal')
xlabel('Time (sec)')
ylabel('Amplitude (Normalised)')

figure
plot(t,method1(1:length(t)))
title('Compressed Signal (With Delay), Perceptual Audio Coding')
xlabel('Time (sec)')
ylabel('Amplitude (Normalised)')

% Find and remove the delay 
n0=finddelay(signal,method1);
noDelay1=method1(n0:end);
noDelay1=( noDelay1(1:length(signal)) )';

figure
plot(t,noDelay1)
title('Compressed Signal (Without Delay), Perceptual Audio Coding')
xlabel('Time (sec)')
ylabel('Amplitude (Normalised)')

% Mean square error
mse1=immse(signal,noDelay1);
error1=(noDelay1-signal);
figure
plot(t,signal)
title('Error, perceptual audio coding')
xlabel('Time (sec)')
ylabel('Amplitude')
hold on
plot(t,error1)
legend('Signal','Error')