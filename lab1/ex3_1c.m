[s_cwt,f_cwt] = wavescales('morl',Fs);

cwtstruct = cwtft({x,1/Fs},'Scales',s_cwt,'Wavelet','morl');

cfs = cwtstruct.cfs';
cfs_ = abs(cfs);

t_cwt = ( (0:size(cfs,1)-1)/size(cfs,1) )*2;
surf(f_cwt,t_cwt,cfs_,'FaceAlpha',0.5,'FaceColor','flat','EdgeColor','none')
xlabel('Frequency (Hz)')
ylabel('Time (sec)')
title('DT-CWT(Morlet) of: 1.5cos(2pi*80*t) + 2.5sin(2pi*150*t) + 0.15u, Fs=1000Hz')