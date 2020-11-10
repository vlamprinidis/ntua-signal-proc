clear all
N=7;
[clean,Fs]=audioread('MicArraySimulatedSignals/source.wav');
clean=clean';
Ns=length(clean); % Ns is the number of samples
sig=zeros(7,Ns); % 7 signals of "Ns" samples each
Fsig=zeros(7,Ns);
% Save input signals in "sig" matrix
% Save their fourier transformation in "Fsig"
for n=1:7
    % Read each one using the file name that results from
    % the concatination of the path, the string "sensor_", the iterator: "n" 
    % and the string ".wav"
    file_name=strcat('MicArraySimulatedSignals/sensor_',int2str(n-1),'.wav');
    sig(n,:)=audioread(file_name);
    Fsig(n,:)=fft(sig(n,:));
end
k=(-Ns/2):(Ns/2-1);
num_dft=length(k);
w=zeros(1,num_dft); % Cyclic frequencies vector
% in first dft half are the positive frequencies
w(1:num_dft/2)=2*pi*(k(num_dft/2+1:end)/Ns)*Fs;
% in second half are the negative frequencies, in ascending order
w(num_dft/2+1:end)=2*pi*(k(1:num_dft/2)/Ns)*Fs;
c=340; % Sound velocity
d=0.04;
thS=45;
ds=zeros(N,Ns);
% Compute the delay filter
for n=1:N
    ds(n,:)=exp(1i*((N-1)/2)*(w/c)*d*(cosd(thS))).*exp(-1i*(n-1)*w*d*(cosd(thS))/c);
end
Y=zeros(N,Ns);
y=zeros(N,Ns);
for n=1:7
    Y(n,:)=(ds(n,:)) .*(Fsig(n,:)); % Apply delay filter on the input signals        
    y(n,:)=real(ifft(Y(n,:))); % Time domain representation
end
y_beam=mean(y,1); % Averaging
% Check if the result is correct by listening to the noise
noise = clean - y_beam;
sound(noise,Fs)

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

noise_mic=clean-sig(3,:);
noise_beam=clean-y_beam;
% Result is in decibels
snr_mic=snr(sig(3,:),noise_mic);
snr_beam=snr(y_beam,noise_beam);

audiowrite('sim_ds.wav',y_beam,Fs)