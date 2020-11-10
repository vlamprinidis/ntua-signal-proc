close all
L=0.030*Fs;
% If Lmod2=1 and R=(L-1)/2 then we would have a problem for hamming window
R=L*0.5;
win = hamming(L)';
noise_mic_frame=buffer(noise_mic,L,R)';
beam_frame=buffer(y_beam,L,R)';

numWin=size(noise_mic_frame,1);
fNs=size(noise_mic_frame,2);

win2=hamming(100);
Pu=pwelch(hamming(0.6*Fs)'.*y_beam(1:0.6*Fs),40,20,fNs,Fs,'two-sided')';
Hw=zeros(numWin,fNs);
for i=1:numWin
   [Pbeam,~]=pwelch(win.*beam_frame(i,:),40,20,fNs,Fs,'two-sided');
   Hw(i,:)=1-Pu./Pbeam'; % Wiener Filter Response 
end

signal_length=length(clean);
final=zeros(signal_length,2);
% Apply filter and do overlap add
for i=1:numWin
    % Compute response in discrete time and
    % Apply wiener filter
    w=real(ifft(Hw(i,:)));
%     y=conv(beam_frame(i,:),w);
    y=real(ifft( fft(w).*fft(beam_frame(i,:)) ));
    A = min(R*(i-1)+1,signal_length);
    B = min(R*(i-1)+L,signal_length);
    if A>=B
        break;
    end
    final( A:B ) = final( A:B ) + y( 1 : min(B-A+1,L) );
end

% Normalize amplitude for every signal to compare
final=final/max(abs(final));
final=final';
sound(final,Fs)
audiowrite('real_mmse.wav',final,Fs)

% Plot all the waveforms
figure
subplot(4,1,1)
plot(t,clean/max(abs(clean)))
title('clean')
xlabel('Time (sec)')
ylabel('Amplitude')

subplot(4,1,2)
plot(t,sig(3,:)/max(abs(sig(3,:))))
title('Noisy at n=3')
xlabel('Time (sec)')
ylabel('Amplitude')

subplot(4,1,3)
plot(t,y_beam/max(abs(y_beam)))
title('Input of Wiener filter')
xlabel('Time (sec)')
ylabel('Amplitude')

subplot(4,1,4)
plot(t,final)
title('Output of Wiener filter')
xlabel('Time (sec)')
ylabel('Amplitude')

% Plot spectrograms
win = hamming(0.04*Fs)';
overLap = 0.02*Fs;
figure
subplot(4,1,1)
spectrogram(clean,win,overLap,0.04*Fs,Fs);
title('Clean signal')
subplot(4,1,2)
spectrogram(sig(3,:),win,overLap,0.04*Fs,Fs);
title('Noisy at n=3')
subplot(4,1,3)
spectrogram(y_beam,win,overLap,0.04*Fs,Fs);
title('Input of Wiener filter')
subplot(4,1,4)
spectrogram(final,win,overLap,0.04*Fs,Fs);
title('Output of Wiener filter')

%%% SSNR computation %%%

% Split signals into frames
noise_in=clean-y_beam;
noise_out=clean-final;

L = 0.04*Fs;
overLap = L/2;
noise_in_frame=buffer(noise_in,L,overLap)';
noise_out_frame=buffer(noise_out,L,overLap)';
clean_frame=buffer(clean,L,overLap)';
numWin=size(clean_frame,1);

% Compute ssnr of input
pnoise_in=mean(noise_in_frame(10,:).^2);
sum=0;
M=numWin;
for i=1:numWin
   pclean=mean(clean_frame(i,:).^2);
   snri=10*log10(pclean/pnoise_in);
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
ssnr_in_wiener=sum/M;

% Compute ssnr of output
pnoise_out=mean(noise_out_frame(10,:).^2);
sum=0;
M=numWin;
for i=1:numWin
   pclean=mean(clean_frame(i,:).^2);
   snri=10*log10(pclean/pnoise_out);
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
ssnr_out_wiener=sum/M;

% Calculate ssnr for all the input signals
ssnr_all_in=zeros(1,7);
for i=1:7
    clear noise_in noise_in_frame pnoise_in
    noise_in=clean-sig(i,:);
    noise_in_frame=buffer(noise_in,L,overLap)';
    % Compute ssnr of each input
    pnoise_in=mean(noise_in_frame(10,:).^2);
    sum=0;
    M=numWin;
    for i=1:numWin
       pclean=mean(clean_frame(i,:).^2);
       snri=10*log10(pclean/pnoise_in);
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
    ssnr_all_in(i)=sum/M;
end
ssnr_all_in_avg=mean(ssnr_all_in);
improvement_final=(ssnr_out_wiener-ssnr_all_in_avg);