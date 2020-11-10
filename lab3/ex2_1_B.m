frame=(0.36*Fs:0.39*Fs);
fNs=length(frame);
x=sig(3,frame);
s=clean(frame);
[Px,fP]=pwelch(x,[],[],fNs,Fs,'two-sided');
[Ps,~]=pwelch(s,[],[],fNs,Fs,'two-sided');
Hw=Ps./Px; % Wiener Filter Response
f=fP(fP<=8000);
plot(f/1000,10*log10(Hw(1:length(f))))
title('Wiener Filter')
xlabel('f(kHz)')
ylabel('dB')

nsd=(1-Hw(1:length(f))).^2;
figure
plot(f/1000,10*log10(nsd))
title('Speech Distortion Index')
xlabel('f(kHz)')
ylabel('dB')

% Apply wiener filter
w=real(ifft(Hw));
y=real( ifft( Hw'.*fft(x) ) );
% y=conv(x,w);

% Plot all the required power spectrums
[Py,~]=pwelch(y,[],[],fNs,Fs);
[Pu,~]=pwelch(x-s,[],[],fNs,Fs);
figure
flen=length(f);
plot(f/1000,10*log10(Ps(1:flen)),'-','Color','b','LineWidth',2);
hold on
plot(f/1000,10*log10(Px(1:flen)),'--','Color','r','LineWidth',2);
hold on
plot(f/1000,10*log10(Py(1:flen)),'-','Color','g','LineWidth',2);
hold on
plot(f/1000,10*log10(Pu(1:flen)),'--','Color','k');
xlabel('f(kHz)')
ylabel('dB')
title('Power Spectrums')
legend('s(t) (clean)','x(t) (noisy)','y(t) (Wiener output)','u(t) (noise)')

% Find snr
snr_out_wien=snr(y,y-s);
snr_in=snr(x,x-s);

% Find improvement
improvement=snr_beam-snr_out_wien;
[Py_beam,~]=pwelch( y_beam(frame) ,[],[],fNs,Fs);

% Plot all the spectrums
figure
plot(f/1000,10*log10(Ps(1:flen)),'-','Color','b','LineWidth',2);
hold on
plot(f/1000,10*log10(Px(1:flen)),'--','Color','r','LineWidth',2);
hold on
plot(f/1000,10*log10(Py(1:flen)),'-','Color','g','LineWidth',2);
hold on
plot(f/1000,10*log10(Py_beam(1:flen)),'-','Color','m','LineWidth',2);
xlabel('f(kHz)')
ylabel('dB')
title('Power Spectrums')
legend('s(t) (clean)','x(t) (noisy)','y_W_i_e_n_e_r(t)','y_B_e_a_m(t)')