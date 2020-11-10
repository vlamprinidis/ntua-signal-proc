clear s f cwtStr cwt;

[s,f] = wavescales('morl',Fs);

f = f';
cwtStr = cwtft({x,1/Fs},'Scales',s,'Wavelet','morl');
cwt = cwtStr.cfs';
cwt_amp = abs(cwt);
t = linspace(0,2,size(cwt,1));

figure
contour(f,t,cwt_amp,'Fill','on')
xlabel('Frequency (Hz)')
ylabel('Time (sec)')
title('DT-CWT(Morlet) of 1.5cos(2pi*40*t) + 1.5cos(2pi*100*t) + 0.15u + 5 * ( delta(t-0.625) + delta(t-0.650) ), Fs=1000Hz')

