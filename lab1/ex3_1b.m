win = hamming(0.04*Fs)';
overLap = 0.02*Fs;

[s,f,t] = spectrogram(x,win,overLap,0.04*Fs,Fs);
s = s';
s_ = abs(s);

figure
surf(f,t,s_,'FaceAlpha',0.5,'FaceColor','flat','EdgeColor','none')
xlabel('Frequency (Hz)')
ylabel('Time (sec)')
title('STFT of: 1.5cos(2pi*80*t) + 2.5sin(2pi*150*t) + 0.15u, Fs=1000Hz')