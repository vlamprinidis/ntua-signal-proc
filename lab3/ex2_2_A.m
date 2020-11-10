clear all
close all
N=7;
[clean,Fs]=audioread('MicArrayRealSignals/source.wav');
clean=clean';
Ns=length(clean);
sig=zeros(7,Ns);
Fsig=zeros(7,Ns);
for n=1:7
    file_name=strcat('MicArrayRealSignals/sensor_',int2str(n-1),'.wav');
    sig(n,:)=audioread(file_name);
    Fsig(n,:)=fft(sig(n,:));
end
k=(-Ns/2):(Ns/2-1);
num_dft=length(k);
w=zeros(1,num_dft);
% in first dft half are the positive frequencies
w(1:num_dft/2)=2*pi*(k(num_dft/2+1:end)/Ns)*Fs;
% in second half are the negative frequencies, in ascending order
w(num_dft/2+1:end)=2*pi*(k(1:num_dft/2)/Ns)*Fs;
c=340;
d=0.04;
thS=45;
ds=zeros(N,Ns);
for n=1:N
    ds(n,:)=exp(1i*((N-1)/2)*(w/c)*d*(cosd(thS))).*exp(-1i*(n-1)*w*d*(cosd(thS))/c);
end
Y=zeros(N,Ns);
y=zeros(N,Ns);
for n=1:7
    Y(n,:)=(ds(n,:)) .*(Fsig(n,:));        
    y(n,:)=real(ifft(Y(n,:)));
end
y_beam=mean(y,1);

t=[0:Ns-1]/Fs;
figure
subplot(3,1,1)
plot(t,clean)
title('Clean')
subplot(3,1,2)
plot(t,sig(3,:))
title('Noisy at n=3')
subplot(3,1,3)
plot(t,y_beam)
title('y(t) of beamformer')

win = hamming(0.04*Fs)';
overLap = 0.02*Fs;
figure
subplot(3,1,1)
spectrogram(clean,win,overLap,0.04*Fs,Fs);
title('Clean signal')
subplot(3,1,2)
spectrogram(sig(3,:),win,overLap,0.04*Fs,Fs);
title('Noisy at n=3')
subplot(3,1,3)
spectrogram(y_beam,win,overLap,0.04*Fs,Fs);
title('y(t) of beamformer')

audiowrite('real_ds.wav',y_beam,Fs)

noise_beam=clean-y_beam;
noise_mic=clean-sig(3,:);

% Split signals into frames
L = 0.04*Fs;
overLap = L/2;
clean_frame=buffer(clean,L,overLap)';
noise_beam_frame=buffer(noise_beam,L,overLap)';
noise_mic_frame=buffer(noise_mic,L,overLap)';
numWin=size(clean_frame,1);

% Calculate ssnr of beamformer output
pnoise_beam=mean(noise_beam_frame(10,:).^2);
sum=0;
M=numWin;
for i=1:numWin
   pclean=mean(clean_frame(i,:).^2);
   snri=10*log10(pclean/pnoise_beam);
   if snri > 35
       snri=35;
   end
   % Check threshold
   if snri <= 0
       % Ignore this snr from calculation
       M = M-1;
       continue;
   end
   sum = sum + snri;
end
ssnr_beam=sum/M;

% Calculate ssnr of n=3 mic output
pnoise_mic=mean(noise_mic_frame(10,:).^2);
sum=0;
M=numWin;
for i=1:numWin
   pclean=mean(clean_frame(i,:).^2);
   snri=10*log10(pclean/pnoise_mic);
   if snri > 35
       snri=35;
   end
   % Check threshold
   if snri <= 0
       % Ignore this snr from calculation
       M = M-1;
       continue;
   end
   sum = sum + snri;
end
ssnr_mic=sum/M;