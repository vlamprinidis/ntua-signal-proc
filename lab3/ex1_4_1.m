f=2000;
w=2*pi*f;
c=340;
N_=[4 8 16];
d=4*10^(-2);
Stheta=90;
theta=[0:180];
figure
for i=1:3
   N=N_(i);
   B=zeros(1,181);
   for j=1:181
        B(j)=(1/N)*( sin( (N/2)*(w/c)*d*(cosd(theta(j))-cosd(Stheta)) ) / sin( (1/2)*(w/c)*d*(cosd(theta(j))-cosd(Stheta)) ) );
   end
   plot(theta,log10(abs(B)))
   hold on
end
legend('N=4','N=8','N=16')
title('delay-and-sum beam pattern, d=4cm, thetaS=90, f=2kHz')
xlabel('Theta (Degrees)')
ylabel('Amplitute (dB)')