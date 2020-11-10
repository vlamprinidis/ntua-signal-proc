winLens = [0.06 0.04 0.02]*Fs;
i = 1;
for winLen=winLens;
    win = hamming(winLen)';
    overLap = 0.5*winLen;

    [s,f,t] = spectrogram(x,win,overLap,winLen,Fs);
    s = s';
    s_ = abs(s);

    figure
    contour(f,t,s_,'Fill','on')
    xlabel('Frequency (Hz)')
    ylabel('Time (sec)')
    tit = strcat('STFT of 1.5cos(2pi*40*t) + 1.5cos(2pi*100*t) + 0.15u + 5 * ( delta(t-0.625) + delta(t-0.650) ), Fs=1000Hz, Window length: ',int2str(winLen));
    title(tit)
end