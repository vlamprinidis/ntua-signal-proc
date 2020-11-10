close all
figure
tframe = ( 99*(512-1) : 100*(512-1) )/Fs;
plot(tframe,wins(100,:))
title('Frame 100, with hanning')
xlabel('Time (sec)')
ylabel('Amplitude (Normalized)')

figure
subplot(2,1,1)
plot(f/1000,P(100,:))
title('Power Spectrum')
xlabel('Frequency (kHz)')
ylabel('Sound Pressure Level (DB)')

subplot(2,1,2)
plot(bark,P(100,:))
title('Power Spectrum')
xlabel('Frequency (Bark)')
ylabel('Sound Pressure Level (DB)')

figure
t=Ptm(100,:);
t(t==0)=NaN;

subplot(2,1,1)
stem(f/1000,t,'Marker','x')
hold on
plot(f/1000,P(100,:))
hold on
plot(f/1000,Tq)
legend('Tone Maskers','Power Spectrum','ATH')
xlabel('Frequency (Hz)')
ylabel('Magnitude (DB)')
title('Reduced Tone Maskers for frame 100')

subplot(2,1,2)
stem(bark,t,'Marker','x')
hold on
plot(bark,P(100,:))
hold on
plot(bark,Tq)
legend('Tone Maskers','Power Spectrum','ATH')
xlabel('Frequency (Bark)')
ylabel('Magnitude (DB)')
title('Reduced Tone Maskers for frame 100')

figure
t=Pnm(100,:);
t(t==0)=NaN;

subplot(2,1,1)
stem(f/1000,t,'Marker','o')
hold on
plot(f/1000,P(100,:))
hold on
plot(f/1000,Tq)
legend('Noise Maskers','Power Spectrum','ATH')
xlabel('Frequency (Hz)')
ylabel('Magnitude (DB)')
title('Reduced Noise Maskers for frame 100')

subplot(2,1,2)
stem(bark,t,'Marker','o')
hold on
plot(bark,P(100,:))
hold on
plot(bark,Tq)
legend('Noise Maskers','Power Spectrum','ATH')
xlabel('Frequency (Bark)')
ylabel('Magnitude (DB)')
title('Reduced Noise Maskers for frame 100')

%%%%%% Bark 1_5
figure

plot(bark,Tg(100,:))
xlabel('Frequency (Bark)')
ylabel('Magnitude (DB)')
title('Global Masking Threshold')
hold on

plot(bark,P(100,:),'g')
hold on

t=Ptm(100,:);
t(t==0)=NaN;
plot(bark,t,'x')
hold on

t=Pnm(100,:);
t(t==0)=NaN;
plot(bark,t,'o')

plot(bark,Tq,'--r')

legend('Overall Threshold','Original PSD','Tones','Noise','ATH')

%%%%% kHz 1_5

figure

plot(f/1000,Tg(100,:))
xlabel('Frequency (kHz)')
ylabel('Magnitude (DB)')
title('Global Masking Threshold')
hold on

plot(f/1000,P(100,:),'g')
hold on

t=Ptm(100,:);
t(t==0)=NaN;
plot(f/1000,t,'x')
hold on

t=Pnm(100,:);
t(t==0)=NaN;
plot(f/1000,t,'o')

plot(f/1000,Tq,'--r')

legend('Overall Threshold','Original PSD','Tones','Noise','ATH')
